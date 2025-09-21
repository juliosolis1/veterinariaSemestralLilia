// reportes.js - interactúa con backend/controller/reportesController.php
const $ = selector => document.querySelector(selector);

function formatMonthLabel(y, m) {
  return `${y}-${String(m).padStart(2,'0')}`;
}

async function fetchData(action, from, to) {
  const params = new URLSearchParams({action, from, to});
  const resp = await fetch(`../../backend/controller/reportesController.php?${params.toString()}`);
  if (!resp.ok) throw new Error('Error al solicitar datos');
  return resp.json();
}

function drawTable(containerSelector, columns, rows) {
  const container = document.querySelector(containerSelector);
  let html = '<thead><tr>'+columns.map(c=>`<th>${c}</th>`).join('')+'</tr></thead><tbody>';
  rows.forEach(r=>{
    html += '<tr>'+columns.map(c=>`<td>${r[c] ?? ''}</td>`).join('')+'</tr>';
  });
  html += '</tbody>';
  container.innerHTML = html;
}

let charts = {};

function drawLineChart(ctxId, labels, data, label) {
  const ctx = document.getElementById(ctxId).getContext('2d');
  if (charts[ctxId]) charts[ctxId].destroy();
  charts[ctxId] = new Chart(ctx, {type:'line', data:{labels, datasets:[{label, data, fill:true}]}, options:{responsive:true}});
}

function drawBarChart(ctxId, labels, data, label) {
  const ctx = document.getElementById(ctxId).getContext('2d');
  if (charts[ctxId]) charts[ctxId].destroy();
  charts[ctxId] = new Chart(ctx, {type:'bar', data:{labels, datasets:[{label, data}]}, options:{responsive:true}});
}

async function loadAll() {
  const from = $('#fromDate').value || '';
  const to = $('#toDate').value || '';
  try {
    // Ingresos
    const ingresos = await fetchData('ingresos', from, to);
    const labels = ingresos.map(r=>formatMonthLabel(r.year, r.month));
    const totals = ingresos.map(r=>parseFloat(r.total));
    drawLineChart('chartIngresos', labels, totals, 'Ingresos');
    drawTable('#tableIngresos', ['year','month','total'], ingresos);

    // Servicios
    const servicios = await fetchData('servicios', from, to);
    drawBarChart('chartServicios', servicios.map(r=>r.servicio), servicios.map(r=>parseInt(r.cantidad)), 'Servicios');
    drawTable('#tableServicios', ['servicio','cantidad'], servicios);

    // Productos
    const productos = await fetchData('productos', from, to);
    drawBarChart('chartProductos', productos.map(r=>r.producto), productos.map(r=>parseInt(r.cantidad)), 'Productos');
    drawTable('#tableProductos', ['producto','cantidad'], productos);

    // Citas
    const citas = await fetchData('citas', from, to);
    drawBarChart('chartCitas', citas.map(r=>r.estado), citas.map(r=>parseInt(r.cantidad)), 'Citas');
    drawTable('#tableCitas', ['estado','cantidad'], citas);

    // Eficiencia
    const efic = await fetchData('eficiencia', from, to);
    drawBarChart('chartEficiencia', efic.map(r=>r.metric), efic.map(r=>parseFloat(r.value)), 'Eficiencia');
    drawTable('#tableEficiencia', ['metric','value'], efic);

  } catch (e) {
    console.error(e);
    alert('Error cargando reportes. Revise la consola para más detalles.');
  }
}

document.getElementById('btnLoad').addEventListener('click', loadAll);

// Export buttons: send the last loaded datasets to backend for export
async function doExport(type) {
  const from = $('#fromDate').value || '';
  const to = $('#toDate').value || '';
  // ask backend to build the report server-side and return file
  const body = new URLSearchParams({reportType: 'full', from, to, exportType: type});
  const resp = await fetch('../../backend/controller/exportReport.php', {method:'POST', body});
  if (!resp.ok) {
    const txt = await resp.text();
    alert('Error exportando: '+txt);
    return;
  }
  const blob = await resp.blob();
  const disposition = resp.headers.get('content-disposition') || '';
  let filename = '';
  const m = disposition.match(/filename="?([^"]+)"?/);
  if (m) filename = m[1];
  if (!filename) filename = `reportes.${type === 'pdf' ? 'pdf' : 'xlsx'}`;
  const url = URL.createObjectURL(blob);
  const a = document.createElement('a');
  a.href = url; a.download = filename; document.body.appendChild(a);
  a.click(); a.remove(); URL.revokeObjectURL(url);
}

$('#btnExportPdf').addEventListener('click', ()=>doExport('pdf'));
$('#btnExportXlsx').addEventListener('click', ()=>doExport('xlsx'));

// Load defaults: set dates to last 3 months
(() => {
  const today = new Date();
  const prior = new Date(); prior.setMonth(today.getMonth()-3);
  $('#toDate').value = today.toISOString().slice(0,10);
  $('#fromDate').value = prior.toISOString().slice(0,10);
  loadAll();
})();
