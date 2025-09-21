---------------FINAL VERSION------------
-- Creaci�n de la base de datos jerhgkeurjhg
CREATE DATABASE CliniPet;
DROP DATABASE CliniPet
-------------------------------------
-- Creaci�n de las tablas
CREATE TABLE Cliente (
    Cedula NVARCHAR(20) PRIMARY KEY NOT NULL,
    Nombre NVARCHAR(100) NOT NULL,
    Tel�fono NVARCHAR(15) UNIQUE NOT NULL,
    Email NVARCHAR(100) UNIQUE NOT NULL,
    Direcci�n NVARCHAR(255) NOT NULL,
    CantidadDeMascotas INT NOT NULL CHECK (CantidadDeMascotas <= 2)
);



----Creaci�n del cliente dummy para el caso de clientes no registrados
INSERT INTO Cliente (Cedula, Nombre, Tel�fono, Email, Direcci�n, CantidadDeMascotas)
VALUES ('---', 'Contado', '---', '---', '---', 0);


CREATE TABLE Especie (
    EspecieID INT PRIMARY KEY IDENTITY(1,1),
    Nombre NVARCHAR(50) NOT NULL
);

-- Inserci�n de las especies
INSERT INTO Especie (Nombre) VALUES
('Perro'), 
('Gato');

SELECT * FROM Especie;


CREATE TABLE Raza (
    RazaID INT PRIMARY KEY IDENTITY(1,1),
    Nombre NVARCHAR(100) NOT NULL,
    EspecieID INT,
    FOREIGN KEY (EspecieID) REFERENCES Especie(EspecieID)
);

-- Inserci�n de razas de perros
INSERT INTO Raza (Nombre, EspecieID) VALUES
('Labrador Retriever', 1), 
('Golden Retriever', 1),
('Bulldog', 1),
('Beagle', 1),
('Poodle', 1),
('Rottweiler', 1),
('German Shepherd', 1),
('Dachshund', 1),
('Chihuahua', 1),
('Boxer', 1),
('Doberman Pinscher', 1),
('Schnauzer', 1),
('Yorkshire Terrier', 1),
('Shih Tzu', 1),
('Cocker Spaniel', 1),
('Pug', 1),
('Basset Hound', 1),
('Maltese', 1),
('French Bulldog', 1),
('Collie', 1),
('Chow Chow', 1),
('Airedale Terrier', 1),
('Bernese Mountain Dog', 1),
('Great Dane', 1),
('Australian Shepherd', 1),
('Border Collie', 1),
('Cavalier King Charles Spaniel', 1),
('Husky Siberiano', 1),
('Saint Bernard', 1),
('Pit Bull Terrier', 1),
('Italian Greyhound', 1),
('Bull Terrier', 1),
('Akita', 1),
('Shiba Inu', 1),
('Cairn Terrier', 1),
('Basenji', 1),
('Cocker Spaniel Ingl�s', 1),
('Weimaraner', 1),
('Irish Wolfhound', 1),
('Jack Russell Terrier', 1),
('Newfoundland', 1),
('Samoyed', 1),
('Australian Cattle Dog', 1),
('American Staffordshire Terrier', 1),
('Tibetan Mastiff', 1),
('Criollo', 1); 

-- Inserci�n de razas de gatos
INSERT INTO Raza (Nombre, EspecieID) VALUES
('Siam�s', 2),  
('Persa', 2),
('Maine Coon', 2),
('Ragdoll', 2),
('Bengal', 2),
('British Shorthair', 2),
('Sphynx', 2),
('Abyssinian', 2),
('Birmano', 2),
('Ex�tico de Pelo Corto', 2),
('Oriental', 2),
('Scottish Fold', 2),
('Burmese', 2),
('Norwegian Forest', 2),
('Russian Blue', 2),
('American Shorthair', 2),
('Savannah', 2),
('Himalayo', 2),
('Chartreux', 2),
('Manx', 2),
('Devon Rex', 2),
('Cornish Rex', 2),
('Turkish Van', 2),
('Singapura', 2),
('Tonkinese', 2),
('Egyptian Mau', 2),
('Munchkin', 2),
('British Longhair', 2),
('Japanese Bobtail', 2),
('LaPerm', 2),
('Turkish Angora', 2),
('Bombay', 2),
('Somali', 2),
('Oriental Longhair', 2),
('Balinese', 2),
('Cymric', 2),
('Korat', 2),
('American Curl', 2);

select*from Raza where Nombre = 'Criollo'



CREATE TABLE Mascota (
    IDMascota INT IDENTITY(10000, 1) PRIMARY KEY,
    Nombre NVARCHAR(50) NOT NULL,
    Especie NVARCHAR(20) NOT NULL CHECK (Especie IN ('Gato', 'Perro', '-')),
    Peso DECIMAL(5,2) NOT NULL,
    Edad NVARCHAR(30) NOT NULL, -- Almacena la edad en formato a�o, dias, meses lo que se necesite porque si declaro por meses, a�o, dias solo pens� en ponerlos separados, asi que mejor que sea una cadena 
    FechaRegistro DATETIME DEFAULT GETDATE(),
    CedulaCliente NVARCHAR(20) NOT NULL FOREIGN KEY REFERENCES Cliente(Cedula),
    RazaID INT FOREIGN KEY (RazaID) REFERENCES Raza(RazaID),
	Genero NVARCHAR(10) NOT NULL CHECK (Genero IN ('Macho', 'Hembra', '-')),
	Foto VARBINARY(MAX),
);


--- Hacer este insert  primero,  seleccionen todo  hasta el paso 3 gracias, atte la gerencia :)
-- 1. Activar IDENTITY_INSERT para la tabla Mascota
SET IDENTITY_INSERT Mascota ON;
--2
INSERT INTO Mascota (IDMascota,Nombre,Especie, Peso, Edad, CedulaCliente,Genero)
VALUES(0, '---', '-', 0, '-', '---', '-')
--3
SET IDENTITY_INSERT Mascota OFF;




--Tabla de Condiciones Medicas--
DROP TABLE CondicionMedica
CREATE TABLE CondicionMedica (
    CondicionID INT PRIMARY KEY IDENTITY(1,1),
    Nombre NVARCHAR(100) NOT NULL,
    EspecieID INT NOT NULL,
    FOREIGN KEY (EspecieID) REFERENCES Especie(EspecieID)
);

--Tabla de relacion entre mascota y condiciones medicas--
-- Porque una mascota puede tener varias condiciones medicas--
CREATE TABLE MascotaCondicion (
    IDMascota INT,
    CondicionID INT,
    PRIMARY KEY (IDMascota, CondicionID),
    FOREIGN KEY (IDMascota) REFERENCES Mascota(IDMascota),
    FOREIGN KEY (CondicionID) REFERENCES CondicionMedica(CondicionID)
);

--enfermedades de perros
INSERT INTO CondicionMedica (Nombre, EspecieID) VALUES
('Displasia de cadera', 1),
('Parvovirus', 1),
('Moquillo canino', 1),
('Sarna', 1),
('Obesidad', 1),
('Otitis', 1),
('Gastritis', 1),
('Diabetes canina', 1),
('Insuficiencia renal', 1),
('Epilepsia', 1),
('Problemas card�acos', 1),
('Artrosis', 1),
('Alergias cut�neas', 1),
('Leishmaniasis', 1),
('Problemas dentales', 1);

-- enfermedades de gatos
INSERT INTO CondicionMedica (Nombre, EspecieID) VALUES
('Leucemia felina (FeLV)', 2),
('Inmunodeficiencia felina (FIV)', 2),
('Insuficiencia renal', 2),
('Asma felino', 2),
('Hipertiroidismo', 2),
('Diabetes felina', 2),
('Obesidad', 2),
('Sarna', 2),
('Problemas urinarios (FLUTD)', 2),
('Alergias alimentarias', 2),
('Toxoplasmosis', 2),
('Otitis', 2),
('Problemas dentales', 2),
('Calicivirus felino', 2),
('Panleucopenia felina', 2);

select*from CondicionMedica where EspecieID = '2'

DROP TABLE MascotaCodigoQR
CREATE TABLE MascotaCodigoQR ( --Cambie esta tabla--
    ID INT IDENTITY(1,1) PRIMARY KEY,
    IDMascota INT,
    CodigoQR VARBINARY(MAX), 
    FechaGeneracion DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (IDMascota) REFERENCES Mascota(IDMascota)
);

---------------------------------------------------------------------------------------

CREATE TABLE Servicio_Producto (
    IDITEM INT IDENTITY(0100,1) PRIMARY KEY,
    NombreProducto NVARCHAR(100) NOT NULL,
    Tipo NVARCHAR(50) NOT NULL CHECK (Tipo IN ('Servicio', 'Producto')),
    PrecioITEM MONEY NOT NULL
);

-- Inserci�n de Servicios
INSERT INTO Servicio_Producto (NombreProducto, Tipo, PrecioITEM)
VALUES
('Consulta Veterinaria General', 'Servicio', 10.00),
('Consulta Especializada', 'Servicio', 25.00),
('Vacunaci�n Antirr�bica', 'Servicio', 10.00),
('Vacunaci�n Triple Felina', 'Servicio', 15.00),
('Vacunaci�n Polivalente Canina', 'Servicio', 20.00),
('Desparasitaci�n Interna', 'Servicio', 10.00),
('Desparasitaci�n Externa', 'Servicio', 20.00),
('Limpieza Dental B�sica', 'Servicio', 40.00),
('Limpieza Dental Completa', 'Servicio', 60.00),
('Ba�o Antipulgas', 'Servicio', 25.00),
('Corte de U�as', 'Servicio', 8.00),
('Corte de Pelo Est�ndar', 'Servicio', 20.00),
('Corte de Pelo Estilizado', 'Servicio', 30.00),
('Microchip e Identificaci�n', 'Servicio', 45.00),
('Consulta de Emergencia', 'Servicio', 35.00),
('Radiograf�a', 'Servicio', 80.00),
('Ultrasonido', 'Servicio', 45.00),
('Hospitalizaci�n (por d�a)', 'Servicio', 150.00),
('Cirug�a General', 'Servicio', 500.00),
('Cirug�a Especializada', 'Servicio', 1200.00),
('Terapia F�sica para Mascotas', 'Servicio', 60.00),
('Asesoramiento Nutricional', 'Servicio', 35.00),
('Consulta Dermatol�gica', 'Servicio', 45.00),
('Consulta Cardiol�gica', 'Servicio', 60.00),
('Consulta de Comportamiento', 'Servicio', 55.00);

-- Inserci�n de Productos
INSERT INTO Servicio_Producto (NombreProducto, Tipo, PrecioITEM)
VALUES
('Alimento para Perros (15kg)', 'Producto', 65.00),
('Alimento para Gatos (10kg)', 'Producto', 50.00),
('Arena Sanitaria para Gatos', 'Producto', 25.00),
('Juguete de Cuerda para Perros', 'Producto', 15.00),
('Pelota de Goma para Mascotas', 'Producto', 10.00),
('Collar Antipulgas para Perros', 'Producto', 18.99),
('Collar Antipulgas para Gatos', 'Producto', 16.99),
('Champ� Antipulgas', 'Producto', 12.50),
('Champ� Hipoalerg�nico', 'Producto', 14.00),
('Cepillo para Mascotas', 'Producto', 8.00),
('Cama para Perros', 'Producto', 45.00),
('Cama para Gatos', 'Producto', 40.00),
('Transportadora Peque�a', 'Producto', 50.00),
('Transportadora Mediana', 'Producto', 65.00),
('Transportadora Grande', 'Producto', 80.00),
('Rascador para Gatos', 'Producto', 70.00),
('Plato de Comida Antideslizante', 'Producto', 12.00),
('Plato Doble para Mascotas', 'Producto', 15.00),
('Correa Retr�ctil para Perros', 'Producto', 20.00),
('Arn�s para Perros', 'Producto', 25.00),
('Arn�s para Gatos', 'Producto', 18.00),
('Kit de Cepillos Dentales', 'Producto', 10.00),
('Comida H�meda para Perros (6 latas)', 'Producto', 18.00),
('Comida H�meda para Gatos (6 latas)', 'Producto', 16.00),
('Snacks Dentales para Perros', 'Producto', 12.00),
('Snacks para Gatos', 'Producto', 10.00);

-----------------------------------------------------------
-- ============================================
-- TABLAS PARA USUARIOS Y ROLES
-- ============================================

-- Tabla de Roles
CREATE TABLE Roles (
    RolID INT PRIMARY KEY IDENTITY(1,1),
    NombreRol NVARCHAR(50) NOT NULL UNIQUE,
    Descripcion NVARCHAR(255),
    FechaCreacion DATETIME DEFAULT GETDATE()
);

-- Insertar roles b�sicos
INSERT INTO Roles (NombreRol, Descripcion) VALUES
('Administrador', 'Control total del sistema'),
('Operador', 'Operaciones del d�a a d�a'),
('Cliente', 'Propietario de mascotas');

-- Tabla de Usuarios del Sistema
CREATE TABLE Usuarios (
    UsuarioID INT PRIMARY KEY IDENTITY(1,1),
    NombreUsuario NVARCHAR(50) NOT NULL UNIQUE,
    Email NVARCHAR(100) NOT NULL UNIQUE,
    PasswordHash NVARCHAR(255) NOT NULL,
    NombreCompleto NVARCHAR(100) NOT NULL,
    RolID INT NOT NULL,
    Activo BIT DEFAULT 1,
    FechaCreacion DATETIME DEFAULT GETDATE(),
    UltimoAcceso DATETIME NULL,
    CedulaCliente NVARCHAR(20) NULL, -- Solo para usuarios tipo Cliente
    FOREIGN KEY (RolID) REFERENCES Roles(RolID),
    FOREIGN KEY (CedulaCliente) REFERENCES Cliente(Cedula)
);

-- Tabla de Permisos
CREATE TABLE Permisos (
    PermisoID INT PRIMARY KEY IDENTITY(1,1),
    NombrePermiso NVARCHAR(100) NOT NULL UNIQUE,
    Modulo NVARCHAR(50) NOT NULL
);

-- Insertar permisos b�sicos
INSERT INTO Permisos (NombrePermiso, Modulo) VALUES
('usuarios_crear', 'Usuarios'),
('usuarios_leer', 'Usuarios'),
('usuarios_actualizar', 'Usuarios'),
('usuarios_eliminar', 'Usuarios'),
('clientes_crear', 'Clientes'),
('clientes_leer', 'Clientes'),
('clientes_actualizar', 'Clientes'),
('mascotas_crear', 'Mascotas'),
('mascotas_leer', 'Mascotas'),
('mascotas_actualizar', 'Mascotas'),
('consultas_crear', 'Consultas'),
('consultas_leer', 'Consultas'),
('consultas_actualizar', 'Consultas'),
('citas_crear', 'Citas'),
('citas_leer', 'Citas'),
('citas_actualizar', 'Citas'),
('citas_cancelar', 'Citas'),
('vacunas_crear', 'Vacunas'),
('vacunas_leer', 'Vacunas'),
('reportes_ver', 'Reportes'),
('facturacion_ver', 'Facturacion'),
('inventario_actualizar', 'Inventario');


-- Tabla de Roles y Permisos
CREATE TABLE RolesPermisos (
    RolID INT,
    PermisoID INT,
    PRIMARY KEY (RolID, PermisoID),
    FOREIGN KEY (RolID) REFERENCES Roles(RolID),
    FOREIGN KEY (PermisoID) REFERENCES Permisos(PermisoID)
);

-- Asignar permisos a roles
-- Administrador tiene todos los permisos
INSERT INTO RolesPermisos (RolID, PermisoID)
SELECT 1, PermisoID FROM Permisos;

-- Asignaci�n de permisos a Operador (casi completo pero con restricciones)
INSERT INTO RolesPermisos (RolID, PermisoID)
SELECT 2, PermisoID FROM Permisos 
WHERE NombrePermiso NOT IN (
    'usuarios_eliminar'  -- No pueden eliminar permanentemente
);

-- Cliente tiene permisos b�sicos
INSERT INTO RolesPermisos (RolID, PermisoID)
SELECT 3, PermisoID FROM Permisos 
WHERE NombrePermiso IN ('citas_crear', 'citas_leer', 'citas_cancelar', 'mascotas_leer', 'vacunas_leer', 'consultas_leer');

--------------------------------------------
CREATE TABLE Factura (
    IDFactura INT IDENTITY(01000,1) PRIMARY KEY,
    CedulaCliente NVARCHAR(20) NOT NULL FOREIGN KEY REFERENCES Cliente(Cedula),
    IDMascota INT NULL FOREIGN KEY REFERENCES Mascota(IDMascota),
    Fecha DATETIME DEFAULT GETDATE(),
    subtotalf DECIMAL(10, 2) NULL,    
    ITBMSFactura DECIMAL(10, 2) NULL,
    totalFactura DECIMAL(10, 2) NULL,
    UsuarioFirma INT NOT NULL FOREIGN KEY REFERENCES Usuarios(UsuarioID),-- incluir firma por el usuario que realiza la factura
    FechaFirma DATETIME DEFAULT GETDATE() --fecha de la firma
);


CREATE TABLE Venta (
    IDVenta INT IDENTITY(01,1) PRIMARY KEY,
	IDFactura INT NOT NULL FOREIGN KEY REFERENCES Factura(IDFactura),
    IDITEM INT NOT NULL FOREIGN KEY REFERENCES Servicio_Producto(IDITEM),
    CantidadVendida INT NOT NULL CHECK (CantidadVendida > 0),
	PrecioBruto MONEY NOT NULL,
    ITBMSLinea MONEY NOT NULL, 
    totalLinea MONEY NOT NULL
);


CREATE TABLE Inventario (
	IDInventario INT IDENTITY (010,1),
	IDVenta INT NULL FOREIGN KEY REFERENCES Venta(IDVenta),
	IDITEM INT NOT NULL FOREIGN KEY REFERENCES Servicio_Producto(IDITEM),
	EntradaInventario INT NOT NULL CHECK (EntradaInventario >= 0),
    SalidaInventario INT NOT NULL DEFAULT 0 CHECK (SalidaInventario >= 0),
	CantidadDisponible INT NOT NULL DEFAULT 0
);




-----------------------------------------------------------------------------
------------------------Procedimientos Almacenado----------------------------
-----------------------------------------------------------------------------
--Procedimiento para registrar al cliente
DROP PROCEDURE RegistrarCliente
CREATE PROCEDURE RegistrarCliente
    @Cedula NVARCHAR(20),
    @Nombre NVARCHAR(100),
    @Telefono NVARCHAR(15),
    @Email NVARCHAR(100),
    @Direccion NVARCHAR(255)
AS
BEGIN
    -- Validar el formato de la c�dula paname�a, extranjera o pasaporte
    IF NOT (
        @Cedula LIKE '[1-9]%'        -- Provincias 1-9
        OR @Cedula LIKE '1[0-9]-%'   -- Provincias 10-19
        OR @Cedula LIKE 'E-%'        -- Extranjeros
        OR @Cedula LIKE '[A-Z][0-9]%' -- Pasaportes
    )
    BEGIN
        RAISERROR (' El formato de la c�dula no es v�lido.', 16, 1);
        RETURN;
    END;

    -- Verificar si la c�dula ya est� registrada
    IF EXISTS (SELECT 1 FROM Cliente WHERE Cedula = @Cedula)
    BEGIN
        RAISERROR (' La c�dula ya est� registrada.', 16, 1);
        RETURN;
    END;

    -- Verificar si el tel�fono ya est� registrado
    IF EXISTS (SELECT 1 FROM Cliente WHERE Tel�fono = @Telefono)
    BEGIN
        RAISERROR (' El n�mero de tel�fono ya est� registrado.', 16, 1);
        RETURN;
    END;

    -- Validar el formato del correo electr�nico
    IF NOT (@Email LIKE '_%@_%._%')
    BEGIN
        RAISERROR (' El formato del correo electr�nico no es v�lido.', 16, 1);
        RETURN;
    END;

    -- Verificar si el email ya est� registrado
    IF EXISTS (SELECT 1 FROM Cliente WHERE Email = @Email)
    BEGIN
        RAISERROR (' El correo electr�nico ya est� registrado.', 16, 1);
        RETURN;
    END;

    -- Insertar cliente
    INSERT INTO Cliente (Cedula, Nombre, Tel�fono, Email, Direcci�n, CantidadDeMascotas)
    VALUES (@Cedula, @Nombre, @Telefono, @Email, @Direccion, 0);
END;



--------------------------------------------------------
--Procedimiento para registrar Mascota
drop procedure RegistrarMascota 
CREATE PROCEDURE RegistrarMascota
    @Nombre NVARCHAR(50),
    @Especie NVARCHAR(20),
    @Peso DECIMAL(5,2),
    @Edad NVARCHAR(30), 
    @CedulaCliente NVARCHAR(20),
    @RazaID INT,
    @Genero NVARCHAR(10),
    @Foto VARBINARY(MAX) = NULL,
    @Condiciones NVARCHAR(MAX) = NULL 
AS
BEGIN
SET NOCOUNT ON;
    -- Verificar que el cliente exista en la base de datos
    IF NOT EXISTS (SELECT 1 FROM Cliente WHERE Cedula = @CedulaCliente)
    BEGIN
        RAISERROR ('El cliente no existe.', 16, 1);
        RETURN;
    END;

    -- Verificar que el cliente tiene menos de 2 mascotas registradas
    IF (SELECT COUNT(*) FROM Mascota WHERE CedulaCliente = @CedulaCliente) >= 2
    BEGIN
        RAISERROR ('El cliente ya tiene 2 mascotas registradas.', 16, 1);
        RETURN;
    END;

    -- Validar que el peso y la edad sean positivos
    IF @Peso <= 0
    BEGIN
        RAISERROR ('El peso debe ser mayor a cero.', 16, 1);
        RETURN;
    END;

    IF CAST(@Edad AS INT) <= 0
    BEGIN
        RAISERROR ('La edad debe ser mayor a cero.', 16, 1);
        RETURN;
    END;

    -- Verificar que la raza proporcionada es v�lida
    IF NOT EXISTS (SELECT 1 FROM Raza WHERE RazaID = @RazaID)
    BEGIN
        RAISERROR ('La raza proporcionada no es v�lida.', 16, 1);
        RETURN;
    END;

    -- Registrar la mascota
    INSERT INTO Mascota (Nombre, Especie, Peso, Edad, CedulaCliente, RazaID, Genero, Foto)
    VALUES (@Nombre, @Especie, @Peso, @Edad, @CedulaCliente, @RazaID, @Genero, @Foto);

    DECLARE @IDMascota INT = SCOPE_IDENTITY();

     -- Insertar condiciones m�dicas si existen
    IF @Condiciones IS NOT NULL AND @Condiciones <> ''
    BEGIN
        DECLARE @CondicionID INT;
        DECLARE @xml XML = '<r>' + REPLACE(@Condiciones, ',', '</r><r>') + '</r>';
        DECLARE cursorCond CURSOR FOR
            SELECT T.c.value('.', 'INT') FROM @xml.nodes('/r') AS T(c);

        OPEN cursorCond;
        FETCH NEXT FROM cursorCond INTO @CondicionID;
        WHILE @@FETCH_STATUS = 0
        BEGIN
            INSERT INTO MascotaCondicion (IDMascota, CondicionID)
            VALUES (@IDMascota, @CondicionID);
            FETCH NEXT FROM cursorCond INTO @CondicionID;
        END
        CLOSE cursorCond;
        DEALLOCATE cursorCond;
    END;

--Actualizar la cantidad de mascotas del cliente
    UPDATE Cliente
    SET CantidadDeMascotas = CantidadDeMascotas + 1
    WHERE Cedula = @CedulaCliente;
	END;


select * from Mascota
select*From Cliente


-------------------------------------------------------------------------------------
-- procedimiento para consultar la mascota y el cliente
DROP PROCEDURE ConsultarClienteYMascota
CREATE PROCEDURE ConsultarClienteYMascota
    @Cedula NVARCHAR(20) = NULL,  -- Define la longitud del NVARCHAR
    @IDMascota INT = NULL
AS
BEGIN
    SET NOCOUNT ON;  -- Evita que se devuelvan mensajes de conteo de filas afectadas

    SELECT 
        c.Cedula AS CedulaCliente,
        c.Nombre AS NombreCliente,
        c.Tel�fono,
        c.Email,
        c.Direcci�n,
        c.CantidadDeMascotas,
        m.IDMascota,
        m.Nombre AS NombreMascota,
        m.Especie,
        m.Peso,
        m.Edad,
        m.Genero, 
        m.FechaRegistro,
        r.Nombre AS RazaMascota,
        m.Foto,
        STRING_AGG(cm.Nombre, ', ') AS CondicionesMedicas -- Agrega las condiciones m�dicas como una cadena
    FROM 
        Cliente c
    LEFT JOIN 
        Mascota m ON c.Cedula = m.CedulaCliente
    LEFT JOIN 
        Raza r ON m.RazaID = r.RazaID
    LEFT JOIN 
        MascotaCondicion mc ON m.IDMascota = mc.IDMascota
    LEFT JOIN 
        CondicionMedica cm ON mc.CondicionID = cm.CondicionID
    WHERE 
        (@Cedula IS NULL OR c.Cedula = @Cedula)  -- Filtra por c�dula si se proporciona
        AND (@IDMascota IS NULL OR m.IDMascota = @IDMascota)  -- Filtra por ID de mascota si se proporciona
    GROUP BY 
        c.Cedula,
        c.Nombre,
        c.Tel�fono,
        c.Email,
        c.Direcci�n,
        c.CantidadDeMascotas,
        m.IDMascota,
        m.Nombre,
        m.Especie,
        m.Peso,
        m.Edad,
        m.Genero, 
        m.FechaRegistro,
        r.Nombre,
        m.Foto; 
END;

----------------------------------------------------------------------------------------------------------------
--procedimieto de actualizar registro de cliente

CREATE PROCEDURE ActualizarCliente
    @Cedula NVARCHAR(20),
    @Telefono NVARCHAR(15),
    @Email NVARCHAR(100),
    @Direccion NVARCHAR(255)
AS
BEGIN
    -- Validar que la c�dula no est� vac�a
    IF @Cedula IS NULL OR @Cedula = ''
    BEGIN
        RAISERROR ('La c�dula no puede estar vac�a.', 16, 1);
        RETURN;
    END;

    -- Validar el formato de la c�dula
    IF NOT (
        @Cedula LIKE '[1-9]%'          -- Provincias de 1 a 9
        OR @Cedula LIKE '10-%'          -- Provincia 10
        OR @Cedula LIKE 'E-%'           -- Extranjeros
        OR @Cedula LIKE '[A-Z][0-9]%'   -- Pasaportes
    )
    BEGIN
        RAISERROR ('El formato de la c�dula no es v�lido.', 16, 1);
        RETURN;
    END;

    -- Verificar si la c�dula existe en la base de datos
    IF NOT EXISTS (SELECT 1 FROM Cliente WHERE Cedula = @Cedula)
    BEGIN
        RAISERROR ('La c�dula no existe en la base de datos.', 16, 1);
        RETURN;
    END;

    -- Validar el formato del tel�fono (asegurarse que sea solo n�meros)
    IF @Telefono IS NOT NULL AND @Telefono <> '' AND NOT @Telefono LIKE '[0-9]%' 
    BEGIN
        RAISERROR ('El formato del tel�fono no es v�lido. Debe contener solo n�meros.', 16, 1);
        RETURN;
    END;

    -- Validar el formato del correo electr�nico (simple verificaci�n de '@' y '.')
    IF @Email IS NOT NULL AND @Email <> '' AND NOT (@Email LIKE '%@%.%')
    BEGIN
        RAISERROR ('El formato del correo electr�nico no es v�lido.', 16, 1);
        RETURN;
    END;

    -- Actualizar la informaci�n del cliente
    UPDATE Cliente
    SET Tel�fono = @Telefono,
        Email = @Email,
        Direcci�n = @Direccion
    WHERE Cedula = @Cedula;

    PRINT 'Informaci�n del cliente actualizada exitosamente.';
END;
-----------------------------------------------------------------
--procedimiento para actualizar el registro de la mascota
drop procedure ActualizarMascota
CREATE PROCEDURE ActualizarMascota
    @IDMascota INT, 
    @NuevoPeso DECIMAL(5,2), 
    @NuevaEdad NVARCHAR(50),
    @Condiciones NVARCHAR(MAX) = NULL
AS
BEGIN
    -- Evitar el conteo de filas afectadas
    SET NOCOUNT ON;

    -- Validar que el ID de mascota sea positivo y que exista
    IF @IDMascota IS NULL OR @IDMascota <= 0
    BEGIN
        RAISERROR ('El ID de la mascota debe ser un valor positivo.', 16, 1);
        RETURN;
    END;

    IF NOT EXISTS (SELECT 1 FROM Mascota WHERE IDMascota = @IDMascota)
    BEGIN
        RAISERROR ('La mascota no existe.', 16, 1);
        RETURN;
    END;

    -- Validar que el peso sea positivo
    IF @NuevoPeso <= 0
    BEGIN
        RAISERROR ('El peso debe ser un n�mero positivo o mayor que 0', 16, 1);
        RETURN;
    END;

    -- Validar que la nueva edad sea un n�mero y mayor que la edad actual
    DECLARE @EdadActual NVARCHAR;
    SELECT @EdadActual = Edad FROM Mascota WHERE IDMascota = @IDMascota;

    -- Intentar convertir la nueva edad a INT
    DECLARE @NuevaEdadInt INT;
    BEGIN TRY
        SET @NuevaEdadInt = CAST(@NuevaEdad AS INT);
    END TRY
    BEGIN CATCH
        RAISERROR ('La nueva edad debe ser un n�mero entero', 16, 1);
        RETURN;
    END CATCH;

    IF @NuevaEdadInt <= @EdadActual
    BEGIN
        RAISERROR ('La nueva edad debe ser mayor que la edad actual', 16, 1);
        RETURN;
    END;

    -- Actualizar mascota
    UPDATE Mascota
    SET Peso = @NuevoPeso,
        Edad = @NuevaEdad
    WHERE IDMascota = @IDMascota;

    -- Eliminar condiciones actuales
    DELETE FROM MascotaCondicion WHERE IDMascota = @IDMascota;

    -- Insertar nuevas condiciones
    IF @Condiciones IS NOT NULL AND @Condiciones <> ''
    BEGIN
        DECLARE @CondicionID INT;
        DECLARE @xml XML = '<r>' + REPLACE(@Condiciones, ',', '</r><r>') + '</r>';
        DECLARE cursorCond CURSOR FOR
            SELECT T.c.value('.', 'INT') FROM @xml.nodes('/r') AS T(c);

        OPEN cursorCond;
        FETCH NEXT FROM cursorCond INTO @CondicionID;
        WHILE @@FETCH_STATUS = 0
        BEGIN
            INSERT INTO MascotaCondicion (IDMascota, CondicionID)
            VALUES (@IDMascota, @CondicionID);
            FETCH NEXT FROM cursorCond INTO @CondicionID;
        END
        CLOSE cursorCond;
        DEALLOCATE cursorCond;
    END;

    PRINT 'Informaci�n de la mascota actualizada exitosamente.';
END;


select*from Cliente
------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
-- ListarRazasPorEspecie
CREATE PROCEDURE ListarRazasPorEspecie
    @EspecieID INT
AS
BEGIN
    SELECT RazaID, Nombre
    FROM Raza
    WHERE EspecieID = @EspecieID;
END
GO

-- ListarCondicionesPorEspecie
CREATE PROCEDURE ListarCondicionesPorEspecie
    @EspecieID INT
AS
BEGIN
    SELECT CondicionID, Nombre
    FROM CondicionMedica
    WHERE EspecieID = @EspecieID;
END
GO
---------------------------------------------------------------------------------------------------------------------------
-- Procedimiento para generar la factura del servicio prestado
CREATE PROCEDURE GenerarFactura
	@CedulaCliente NVARCHAR(20),
    @IDMascota INT = NULL,
    @UsuarioFirma INT  -- a�adido para guardar el Usuario que firma la factura
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        -- Validar existencia del cliente
        IF NOT EXISTS (SELECT 1 FROM Cliente WHERE Cedula = @CedulaCliente)
        BEGIN
            RAISERROR ('El cliente no existe.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        -- Validar que el usuario existe y est� activo
        IF NOT EXISTS (SELECT 1 FROM Usuarios WHERE UsuarioID = @UsuarioFirma AND Activo = 1)
        BEGIN
            RAISERROR ('Usuario no v�lido para firmar factura.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        -- Insertar la factura CON LA FIRMA
        INSERT INTO Factura (IDMascota, CedulaCliente, Fecha, UsuarioFirma, FechaFirma)
        VALUES (@IDMascota, @CedulaCliente, GETDATE(), @UsuarioFirma, GETDATE());

        -- Obtener el ID de la factura reci�n insertada
        DECLARE @IDFactura INT = SCOPE_IDENTITY();

        -- Confirmar transacci�n
        COMMIT TRANSACTION;
        
        -- Devolver el ID de la factura para poder almacenar en tabla venta
        SELECT @IDFactura AS IDFactura;
        
    END TRY
    BEGIN CATCH
        -- Manejo de errores
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;

-------------------------------------------------------------------------------------------------

---procedimiento de actualizar inventario
CREATE PROCEDURE ActualizarInventario
    @IDITEM INT,
    @CantidadAgregada INT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        -- Verificar que el producto exista
        IF NOT EXISTS (SELECT 1 FROM Servicio_Producto WHERE IDITEM = @IDITEM AND Tipo = 'Producto')
        BEGIN
            RAISERROR ('El producto no existe.', 16, 1);
            RETURN;
        END

        -- Obtener la �ltima cantidad disponible
        DECLARE @CantidadDisponibleAnterior INT;
        SELECT TOP 1 @CantidadDisponibleAnterior = CantidadDisponible 
        FROM Inventario 
        WHERE IDITEM = @IDITEM
        ORDER BY IDInventario DESC; -- Aseguramos que obtenemos el �ltimo registro por IDInventario

        -- Calcular la nueva cantidad disponible
        DECLARE @NuevaCantidadDisponible INT = ISNULL(@CantidadDisponibleAnterior, 0) + @CantidadAgregada;

        -- Insertar nuevo registro en inventario
        INSERT INTO Inventario (IDITEM, EntradaInventario, SalidaInventario, CantidadDisponible)
        VALUES (@IDITEM, @CantidadAgregada, 0, @NuevaCantidadDisponible);

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;


-----------------------------------------------------------------------------------------------
--Procedimiento almacenado para la compra de producto
CREATE PROCEDURE ComprarProducto
  @IDITEM INT,
    @Cantidad INT,
    @IDFactura INT -- Asociar la compra a una factura
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        -- Verificar que el producto exista
        IF NOT EXISTS (SELECT 1 FROM Servicio_Producto WHERE IDITEM = @IDITEM AND Tipo = 'Producto')
        BEGIN
            RAISERROR ('El producto no existe.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        -- Verificar que la factura exista
        IF NOT EXISTS (SELECT 1 FROM Factura WHERE IDFactura = @IDFactura)
        BEGIN
            RAISERROR ('La factura no existe.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        -- Verificar la cantidad disponible en inventario
        DECLARE @CantidadDisponible INT;
        SELECT @CantidadDisponible = CantidadDisponible
        FROM Inventario 
        WHERE IDITEM = @IDITEM;



        IF @CantidadDisponible < @Cantidad
        BEGIN
            RAISERROR ('Cantidad insuficiente en inventario.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        -- Obtener el precio del producto desde la tabla Servicio_Producto
        DECLARE @PrecioUnitario MONEY;
        SELECT @PrecioUnitario = PrecioITEM FROM Servicio_Producto WHERE IDITEM = @IDITEM;

        -- Validar que se encontr� el precio del producto
        IF @PrecioUnitario IS NULL
        BEGIN
            RAISERROR ('No se encontr� el precio del producto.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        -- Calcular el ITBMS y el total de la l�nea
        DECLARE @ITBMSLinea MONEY = @PrecioUnitario * @Cantidad * 0.07;
        DECLARE @TotalLinea MONEY = @PrecioUnitario * @Cantidad + @ITBMSLinea;

        -- Insertar la venta
        INSERT INTO Venta (IDFactura, IDITEM, CantidadVendida, PrecioBruto, ITBMSLinea, TotalLinea)
        VALUES (@IDFactura, @IDITEM, @Cantidad, @PrecioUnitario * @Cantidad, @ITBMSLinea, @TotalLinea);

        -- Actualizar el inventario
        INSERT INTO Inventario (IDITEM, EntradaInventario, SalidaInventario, CantidadDisponible, IDVenta)
        VALUES (
            @IDITEM, 
            0, -- porque no ehay entrada
            @Cantidad, -- Cantidad vendida
            @CantidadDisponible - @Cantidad, -- Nueva cantidad disponible
            SCOPE_IDENTITY() -- ID de la venta reci�n creada
        );

        -- Confirmar la transacci�n
        COMMIT TRANSACTION;

        PRINT 'Compra de producto registrada exitosamente.';
    END TRY
    BEGIN CATCH
        -- Manejar errores y deshacer cambios
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;
----------------------------------------------------------------------------------------------------------------------
--para consultar facturas con firmas
CREATE PROCEDURE ObtenerFacturaConFirma
    @IDFactura INT
AS
BEGIN
    SELECT 
        f.IDFactura,
        f.CedulaCliente,
        c.Nombre AS NombreCliente,
        f.IDMascota,
        m.Nombre AS NombreMascota,
        f.Fecha AS FechaFactura,
        f.subtotalf,
        f.ITBMSFactura,
        f.totalFactura,
        -- INFORMACI�N DE LA FIRMA
        f.UsuarioFirma,
        u.NombreCompleto AS NombreFirmante,
        u.NombreUsuario AS UsuarioFirmante,
        r.NombreRol AS RolFirmante,
        f.FechaFirma
    FROM Factura f
    INNER JOIN Cliente c ON f.CedulaCliente = c.Cedula
    LEFT JOIN Mascota m ON f.IDMascota = m.IDMascota
    INNER JOIN Usuarios u ON f.UsuarioFirma = u.UsuarioID
    INNER JOIN Roles r ON u.RolID = r.RolID
    WHERE f.IDFactura = @IDFactura;
END;

--------------------------------------------------------------------------------------------------------------------------
--Procedimiento almacenado para el registro del servicio realizado a la mascota
CREATE PROCEDURE RegistrarServicioMascota
    @IDMascota INT,
    @IDITEM INT,
    @IDFactura INT -- Se agrega este par�metro para asociar la venta a la factura
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        -- Verificar que la mascota existe
        IF NOT EXISTS (SELECT 1 FROM Mascota WHERE IDMascota = @IDMascota)
        BEGIN
            RAISERROR ('La mascota no existe.', 16, 1);
            RETURN;
        END

        -- Verificar que el servicio existe
        IF NOT EXISTS (SELECT 1 FROM Servicio_Producto WHERE IDITEM = @IDITEM AND Tipo = 'Servicio')
        BEGIN
            RAISERROR ('El servicio no existe.', 16, 1);
            RETURN;
        END

        -- Verificar que la factura existe
        IF NOT EXISTS (SELECT 1 FROM Factura WHERE IDFactura = @IDFactura)
        BEGIN
            RAISERROR ('La factura no existe.', 16, 1);
            RETURN;
        END

        -- Obtener precio del servicio
        DECLARE @PrecioServicio MONEY = (SELECT PrecioITEM FROM Servicio_Producto WHERE IDITEM = @IDITEM);
        DECLARE @ITBMSLinea MONEY = @PrecioServicio * 0.07;
        DECLARE @totalLinea MONEY = @PrecioServicio + @ITBMSLinea;

        -- Registrar la venta asociada a la factura
        INSERT INTO Venta (IDFactura, IDITEM, CantidadVendida, PrecioBruto, ITBMSLinea, totalLinea)
        VALUES (@IDFactura, @IDITEM, 1, @PrecioServicio, @ITBMSLinea, @totalLinea);

        COMMIT TRANSACTION;

        PRINT 'Servicio registrado exitosamente.';
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH;
END;



----------------------------------------------------------------------
------------procedimiento para Completar la factura
CREATE PROCEDURE CompletarFactura
    @IDFactura INT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        -- Calcular el subtotal sumando todas las l�neas de la factura
        DECLARE @Subtotal DECIMAL(10, 2);
        SELECT @Subtotal = SUM(PrecioBruto)
        FROM Venta
        WHERE IDFactura = @IDFactura;

        -- Calcular el ITBMS (7% del subtotal)
        DECLARE @ITBMS DECIMAL(10, 2) = @Subtotal * 0.07;

        -- Calcular el total (subtotal + ITBMS)
        DECLARE @Total DECIMAL(10, 2) = @Subtotal + @ITBMS;

        -- Actualizar los campos de la factura
        UPDATE Factura
        SET 
            subtotalf = @Subtotal,
            ITBMSFactura = @ITBMS,
            totalFactura = @Total
        WHERE IDFactura = @IDFactura;

        COMMIT TRANSACTION;

        PRINT 'Factura completada correctamente.';
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;

select*from Raza
select* from Factura
select* from Servicio_Producto where Tipo = 'Servicio'


--------------------------Para los reportes------------------------------------------------------------------------------------------------

--Procedimiento almacenado que obtiene el producto mas vendido

CREATE PROCEDURE ObtenerProductosMasVendidos
AS
BEGIN
    WITH ProductosVendidos AS (
        SELECT 
            SP.NombreProducto, 
            SUM(V.CantidadVendida) AS TotalVendido,
            ROW_NUMBER() OVER (ORDER BY SUM(V.CantidadVendida) DESC) AS RowNum
        FROM Venta V
        INNER JOIN Servicio_Producto SP ON V.IDITEM = SP.IDITEM
        WHERE SP.Tipo = 'Producto'
        GROUP BY SP.NombreProducto
    )
    SELECT NombreProducto, TotalVendido
    FROM ProductosVendidos
    WHERE RowNum <= 5; -- Top 5 productos m�s vendidos
END;


--------------------------------------------------------------------------------------------------------------------------
CREATE PROCEDURE ObtenerServicioMasSolicitado
AS
BEGIN
    WITH ServiciosSolicitados AS (
        SELECT 
            SP.NombreProducto AS NombreServicio, 
            COUNT(V.IDVenta) AS TotalSolicitado,
            ROW_NUMBER() OVER (ORDER BY COUNT(V.IDVenta) DESC) AS RowNum
        FROM Venta V
        INNER JOIN Servicio_Producto SP ON V.IDITEM = SP.IDITEM
        WHERE SP.Tipo = 'Servicio'
        GROUP BY SP.NombreProducto
    )
    SELECT NombreServicio, TotalSolicitado
    FROM ServiciosSolicitados
    WHERE RowNum = 1; -- Servicio m�s solicitado
END;


----------------------------- data de prueba --------------------------------

INSERT INTO Cliente (Cedula, Nombre, Tel�fono, Email, Direcci�n, CantidadDeMascotas)
VALUES 
('8-123-4567', 'Ana L�pez', '8888-8888', 'ana.lopez@gmail.com', 'Calle Flores 123, San Jos�', 2),
('9-234-5678', 'Carlos Mart�nez', '7777-7777', 'carlos.mtz@hotmail.com', 'Avenida Central, San Pedro', 1),
('7-345-6789', 'Mar�a Fern�ndez', '6666-6666', 'maria.fernandez@yahoo.com', 'Barrio Los Olivos, Heredia', 2);


INSERT INTO Mascota (Nombre, Especie, Peso, Edad, CedulaCliente, RazaID, Genero, Foto)
VALUES 
('Rocky', 'Perro', 25.50, '5 a�os', '8-123-4567', 1, 'Macho', NULL), -- Labrador Retriever
('Luna', 'Gato', 4.20, '1 a�o', '9-234-5678', 24, 'Hembra', NULL), -- Siam�s
('Max', 'Perro', 30.00, '7 a�os', '7-345-6789', 8, 'Macho', NULL); -- Beagle


select * from Mascota
----------------------------------------------------------------------------------------

INSERT INTO Inventario (IDITEM, EntradaInventario, SalidaInventario, CantidadDisponible)
VALUES
(125, 50, 0, 50),  -- Alimento para Perros (15kg)
(126, 40, 0, 40),  -- Alimento para Gatos (10kg)
(127, 30, 0, 30),  -- Arena Sanitaria para Gatos
(128, 20, 0, 20),  -- Juguete de Cuerda para Perros
(129, 25, 0, 25),  -- Pelota de Goma para Mascotas
(130, 15, 0, 15),  -- Collar Antipulgas para Perros
(131, 10, 0, 10),  -- Collar Antipulgas para Gatos
(132, 20, 0, 20),  -- Champ� Antipulgas
(133, 15, 0, 15),  -- Champ� Hipoalerg�nico
(134, 30, 0, 30),  -- Cepillo para Mascotas
(135, 10, 0, 10),  -- Cama para Perros
(136, 8, 0, 8),    -- Cama para Gatos
(137, 12, 0, 12),  -- Transportadora Peque�a
(138, 10, 0, 10),  -- Transportadora Mediana
(139, 5, 0, 5),    -- Transportadora Grande
(140, 6, 0, 6),    -- Rascador para Gatos
(141, 25, 0, 25),  -- Plato de Comida Antideslizante
(142, 20, 0, 20),  -- Plato Doble para Mascotas
(143, 15, 0, 15),  -- Correa Retr�ctil para Perros
(144, 18, 0, 18),  -- Arn�s para Perros
(145, 12, 0, 12),  -- Arn�s para Gatos
(146, 50, 0, 50),  -- Kit de Cepillos Dentales
(147, 25, 0, 25),  -- Comida H�meda para Perros (6 latas)
(148, 30, 0, 30),  -- Comida H�meda para Gatos (6 latas)
(149, 40, 0, 40),  -- Snacks Dentales para Perros
(150, 35, 0, 35);  -- Snacks para Gatos

---------------------------------
select*from Mascota where IDMascota = '0'

SELECT * FROM Factura
SELECT* FROM Servicio_Producto WHERE IDITEM = '126'
EXEC ConsultarClienteYMascota @Cedula = NULL, @IDMascota = 10001
EXEC ConsultarClienteYMascota @Cedula = '9-234-5678', @IDMascota = NULL
EXEC ConsultarClienteYMascota @Cedula = '9-234-5678', @IDMascota = 10001


SELECT * FROM Cliente

SELECT * FROM Mascota

SELECT * FROM Inventario

SELECT name FROM sys.check_constraints
WHERE parent_object_id = OBJECT_ID('Mascota') AND name LIKE '%Genero%';

alter table Mascota
drop constraint CK__Mascota__Genero__440B1D61

ALTER TABLE Mascota
ADD CONSTRAINT CK_Mascota_Genero
CHECK (Genero IN ('Macho', 'Hembra', '-'))




-----------------------------------------------------------------------------
--------------------Procedimientos Almacenados Agregados---------------------
-----------------------------------------------------------------------------

-- ============================================
-- PROCEDIMIENTOS PARA USUARIOS Y AUTENTICACI�N
-- ============================================


DROP PROCEDURE IF EXISTS CrearUsuario;


CREATE PROCEDURE CrearUsuario
    @NombreUsuario NVARCHAR(50),
    @Email NVARCHAR(100),
    @PasswordHash NVARCHAR(255),
    @NombreCompleto NVARCHAR(100),
    @RolID INT,
    @CedulaCliente NVARCHAR(20) = NULL,
    @UsuarioCreadorID INT = NULL,
    @Telefono NVARCHAR(15) = NULL,
    @Direccion NVARCHAR(255) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Validar rol cliente requiere c�dula
        IF @RolID = 3 AND (@CedulaCliente IS NULL OR @CedulaCliente = '')
        BEGIN
            RAISERROR('Se requiere c�dula v�lida para usuarios cliente', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END;

        -- Si es un cliente (RolID = 3), validar par�metros adicionales y crear cliente
        IF @RolID = 3 
        BEGIN
            IF @Telefono IS NULL OR @Telefono = ''
            BEGIN
                RAISERROR('Se requiere tel�fono para usuarios cliente', 16, 1);
                ROLLBACK TRANSACTION;
                RETURN;
            END;
            
            IF @Direccion IS NULL OR @Direccion = ''
            BEGIN
                RAISERROR('Se requiere direcci�n para usuarios cliente', 16, 1);
                ROLLBACK TRANSACTION;
                RETURN;
            END;
            
            -- Llamar al procedimiento RegistrarCliente
            EXEC RegistrarCliente 
                @Cedula = @CedulaCliente, 
                @Nombre = @NombreCompleto, 
                @Telefono = @Telefono, 
                @Email = @Email, 
                @Direccion = @Direccion;
        END;
        
        -- Si no es cliente, validar que la c�dula existe (si se proporciona)
        IF @RolID != 3 AND @CedulaCliente IS NOT NULL AND @CedulaCliente != ''
        BEGIN
            IF NOT EXISTS (SELECT 1 FROM Cliente WHERE Cedula = @CedulaCliente)
            BEGIN
                RAISERROR('La c�dula proporcionada no existe en la tabla Cliente', 16, 1);
                ROLLBACK TRANSACTION;
                RETURN;
            END;
        END;
        
        -- Insertar usuario
        INSERT INTO Usuarios (
            NombreUsuario, Email, PasswordHash, 
            NombreCompleto, RolID, CedulaCliente
        )
        VALUES (
            @NombreUsuario, @Email, @PasswordHash,
            @NombreCompleto, @RolID, @CedulaCliente
        );
        
        DECLARE @NuevoUsuarioID INT = SCOPE_IDENTITY();
        
        COMMIT TRANSACTION;
        
        -- Retornar el ID del nuevo usuario
        SELECT @NuevoUsuarioID AS UsuarioID, 'Usuario creado exitosamente' AS Mensaje;
        
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        -- Capturar y relanzar el error
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();
        
        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;
GO

----------------------------------------------------------------------

-- Procedimiento para autenticar usuario
CREATE PROCEDURE AutenticarUsuario
    @NombreUsuario NVARCHAR(50)
AS
BEGIN
    -- Obtener datos del usuario incluyendo informaci�n de rol
    SELECT 
        u.UsuarioID,
        u.NombreUsuario,
        u.Email,
        u.PasswordHash,
        u.NombreCompleto,
        r.RolID,
        r.NombreRol,
        u.Activo,
        u.CedulaCliente,
        u.UltimoAcceso
    FROM Usuarios u
    INNER JOIN Roles r ON u.RolID = r.RolID
    WHERE u.NombreUsuario = @NombreUsuario;
    
    -- Actualizar �ltimo acceso si existe el usuario
    IF @@ROWCOUNT > 0
    BEGIN
        UPDATE Usuarios 
        SET UltimoAcceso = GETDATE() 
        WHERE NombreUsuario = @NombreUsuario;
    END
END;

----------------------------------------------------------

-- Procedimiento para actualizar usuario con restricciones

DROP PROCEDURE IF EXISTS ActualizarUsuario;

CREATE PROCEDURE ActualizarUsuario
    @UsuarioID INT,
    @NombreCompleto NVARCHAR(100) = NULL,
    @Email NVARCHAR(100) = NULL,
    @CedulaCliente NVARCHAR(20) = NULL,
    @Activo BIT = NULL,
    @UsuarioEditorID INT,  -- Requerido para validaci�n de permisos
    @Telefono NVARCHAR(15) = NULL,
    @Direccion NVARCHAR(255) = NULL
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        -- Obtener informaci�n del usuario actual
        DECLARE @RolUsuario INT, @CedulaActual NVARCHAR(20);
        SELECT @RolUsuario = RolID, @CedulaActual = CedulaCliente 
        FROM Usuarios 
        WHERE UsuarioID = @UsuarioID;

        -- Validar que el usuario existe
        IF @RolUsuario IS NULL
        BEGIN
            RAISERROR('El usuario no existe', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END;

        -- Obtener informaci�n del editor
        DECLARE @RolEditor INT;
        SELECT @RolEditor = RolID FROM Usuarios WHERE UsuarioID = @UsuarioEditorID;
        
        -- Validar permisos seg�n rol
        IF @RolEditor = 2  -- Si es operador
        BEGIN
            -- Operadores no pueden modificar otros operadores o admins
            IF @RolUsuario IN (1, 2)
            BEGIN
                RAISERROR('No tienes permisos para modificar este usuario', 16, 1);
                ROLLBACK TRANSACTION;
                RETURN;
            END;
            
            -- Operadores no pueden cambiar el estado de activaci�n
            IF @Activo IS NOT NULL
            BEGIN
                RAISERROR('No puedes cambiar el estado de activaci�n', 16, 1);
                ROLLBACK TRANSACTION;
                RETURN;
            END;
        END;

        -- Si es un cliente (RolID = 3), actualizar informaci�n en tabla Cliente
        IF @RolUsuario = 3 AND @CedulaActual IS NOT NULL
        BEGIN
            -- Preparar par�metros para ActualizarCliente
            DECLARE @TelefonoFinal NVARCHAR(15) = @Telefono;
            DECLARE @EmailFinal NVARCHAR(100) = ISNULL(@Email, (SELECT Email FROM Usuarios WHERE UsuarioID = @UsuarioID));
            DECLARE @DireccionFinal NVARCHAR(255) = @Direccion;
            
            -- Solo llamar ActualizarCliente si se proporcionaron datos para actualizar
            IF @TelefonoFinal IS NOT NULL OR @DireccionFinal IS NOT NULL OR @Email IS NOT NULL
            BEGIN
                -- Obtener valores actuales si no se proporcionaron nuevos
                IF @TelefonoFinal IS NULL
                    SELECT @TelefonoFinal = Tel�fono FROM Cliente WHERE Cedula = @CedulaActual;
                    
                IF @DireccionFinal IS NULL
                    SELECT @DireccionFinal = Direcci�n FROM Cliente WHERE Cedula = @CedulaActual;
                
                -- Llamar al procedimiento ActualizarCliente
                EXEC ActualizarCliente 
                    @Cedula = @CedulaActual,
                    @Telefono = @TelefonoFinal,
                    @Email = @EmailFinal,
                    @Direccion = @DireccionFinal;
            END;
        END;
        
        -- Actualizar solo campos de usuario permitidos
        UPDATE Usuarios SET
            NombreCompleto = ISNULL(@NombreCompleto, NombreCompleto),
            Email = ISNULL(@Email, Email),
            CedulaCliente = ISNULL(@CedulaCliente, CedulaCliente),
            Activo = CASE 
                        WHEN @RolEditor = 1 THEN ISNULL(@Activo, Activo) 
                        ELSE Activo 
                     END
        WHERE UsuarioID = @UsuarioID;
        
        COMMIT TRANSACTION;
        
        SELECT 'Usuario actualizado exitosamente' AS Mensaje;
        
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();
        
        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH;
END;
GO

------------------------------------------------------------

-- Procedimiento para obtener permisos de usuario
CREATE PROCEDURE ObtenerPermisosUsuario
    @UsuarioID INT
AS
BEGIN
    -- Verificar que el usuario existe y est� activo
    IF NOT EXISTS (SELECT 1 FROM Usuarios WHERE UsuarioID = @UsuarioID AND Activo = 1)
    BEGIN
        RAISERROR('Usuario no encontrado o inactivo', 16, 1);
        RETURN;
    END;
    
    -- Obtener permisos directos del rol
    SELECT 
        p.PermisoID,
        p.NombrePermiso,
        p.Modulo,
        1 AS TienePermiso  -- Siempre true porque viene de RolesPermisos
    FROM Usuarios u
    INNER JOIN RolesPermisos rp ON u.RolID = rp.RolID
    INNER JOIN Permisos p ON rp.PermisoID = p.PermisoID
    WHERE u.UsuarioID = @UsuarioID
    ORDER BY p.Modulo, p.NombrePermiso;
END;

-------------------------------------------------------------------
-- Procedimiento para listar usuarios con filtros por rol
CREATE PROCEDURE ListarUsuarios
    @UsuarioSolicitanteID INT
AS
BEGIN
    DECLARE @RolSolicitante INT;
    SELECT @RolSolicitante = RolID FROM Usuarios WHERE UsuarioID = @UsuarioSolicitanteID;
    
    -- Administradores ven todos los usuarios
    IF @RolSolicitante = 1
    BEGIN
        SELECT 
            u.UsuarioID,
            u.NombreUsuario,
            u.Email,
            u.NombreCompleto,
            r.NombreRol,
            u.Activo,
            u.FechaCreacion,
            u.UltimoAcceso
        FROM Usuarios u
        INNER JOIN Roles r ON u.RolID = r.RolID
        ORDER BY u.Activo DESC, r.RolID, u.NombreUsuario;
    END
    -- Operadores ven solo clientes
    ELSE IF @RolSolicitante = 2
    BEGIN
        SELECT 
            u.UsuarioID,
            u.NombreUsuario,
            u.Email,
            u.NombreCompleto,
            r.NombreRol,
            u.Activo,
            u.FechaCreacion,
            u.UltimoAcceso
        FROM Usuarios u
        INNER JOIN Roles r ON u.RolID = r.RolID
        WHERE u.RolID = 3  -- Solo clientes
        ORDER BY u.Activo DESC, u.NombreUsuario;
    END
    ELSE
    BEGIN
        RAISERROR('Acceso no autorizado', 16, 1);
    END
END;


--------------------------------------------------------------------
-- Procedimiento para cambiar estado de usuario (activar/desactivar)
CREATE PROCEDURE CambiarEstadoUsuario
    @UsuarioID INT,
    @Activo BIT,
    @UsuarioEditorID INT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;
        
        DECLARE @RolEditor INT, @RolUsuario INT;
        
        SELECT @RolEditor = RolID FROM Usuarios WHERE UsuarioID = @UsuarioEditorID;
        SELECT @RolUsuario = RolID FROM Usuarios WHERE UsuarioID = @UsuarioID;
        
        -- Validar permisos
        IF @RolEditor = 2  -- Si es operador
        BEGIN
            -- Operadores solo pueden desactivar clientes
            IF @RolUsuario <> 3
            BEGIN
                RAISERROR('No tienes permisos para esta acci�n', 16, 1);
                RETURN;
            END;
        END;
        
        -- Actualizar estado
        UPDATE Usuarios 
        SET Activo = @Activo 
        WHERE UsuarioID = @UsuarioID;
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH;
END;


----------------------------------------------------------------
--Procedimiento para obtener la info de usuario 
CREATE PROCEDURE ObtenerInfoCompletaUsuario
    @UsuarioID INT
AS
BEGIN
    SELECT 
        u.UsuarioID,
        u.NombreUsuario,
        u.Email,
        u.NombreCompleto,
        r.RolID,
        r.NombreRol,
        u.Activo,
        u.CedulaCliente,
        c.Nombre AS NombreCliente,  -- Desde tabla Cliente
        u.FechaCreacion,
        u.UltimoAcceso
    FROM Usuarios u
    INNER JOIN Roles r ON u.RolID = r.RolID
    LEFT JOIN Cliente c ON u.CedulaCliente = c.Cedula
    WHERE u.UsuarioID = @UsuarioID;
END;


------------------------------------------------------------------


ALTER PROCEDURE EliminarUsuario
CREATE PROCEDURE EliminarUsuario
    @UsuarioID INT,           -- ID del usuario a eliminar
    @UsuarioSolicitanteID INT -- ID del usuario que solicita la eliminaci�n
AS
BEGIN
    SET NOCOUNT ON;

    -- Validar que el solicitante sea administrador
    DECLARE @RolSolicitante INT;
    SELECT @RolSolicitante = RolID FROM Usuarios WHERE UsuarioID = @UsuarioSolicitanteID;

    IF @RolSolicitante IS NULL OR @RolSolicitante <> 1
    BEGIN
        RAISERROR('Solo un administrador puede eliminar usuarios.', 16, 1);
        RETURN;
    END

    -- No permitir que un admin se elimine a s� mismo
    IF @UsuarioID = @UsuarioSolicitanteID
    BEGIN
        RAISERROR('No puedes eliminarte a ti mismo.', 16, 1);
        RETURN;
    END

    -- Eliminar el usuario
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Eliminar dependencias primero
        DELETE FROM RolesPermisos WHERE RolID IN (SELECT RolID FROM Usuarios WHERE UsuarioID = @UsuarioID);
        DELETE FROM Usuarios WHERE UsuarioID = @UsuarioID;
        
        COMMIT TRANSACTION;
        
        SELECT 'Usuario eliminado exitosamente' as Mensaje;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        RAISERROR('Error al eliminar usuario: %s', 16, 1);
    END CATCH
END;



----------------------------------------
-- Crear usuario administrador
EXEC CrearUsuario 'admin', 'admin@clinipet.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Administrador Principal', 1, NULL, NULL;

-- Crear usuario operador/trabajador  
EXEC CrearUsuario 'trabajador1', 'trabajador@clinipet.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Dr. Garc�a', 2, NULL, 1;

-- Crear usuario cliente (usar c�dula existente en tu tabla Cliente)
EXEC CrearUsuario 'cliente1', 'cliente@email.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Juan P�rez', 3, '8-123-4567',�1;

SELECT * FROM Usuarios
SELECT * FROM Cliente
---------------------------------------------------------------
-------------------------------------------------------------------
-- PROCEDIMIENTOS ALMACENADOS PARA GESTI�N DE INVENTARIO
-- ====================================================
-----------------
-- PROCEDIMIENTO CORREGIDO PARA OBTENER PRODUCTOS SIN DUPLICADOS
-- ================================================================
ALTER PROCEDURE ObtenerProductosInventario
CREATE PROCEDURE ObtenerProductosInventario
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        sp.IDITEM,
        sp.NombreProducto,
        sp.PrecioITEM,
        sp.Tipo,
        ISNULL(inv_ultimo.CantidadDisponible, 0) as CantidadDisponible,
        ISNULL(inv_ultimo.EntradaInventario, 0) as EntradaInventario,
        ISNULL(inv_ultimo.SalidaInventario, 0) as SalidaInventario
    FROM Servicio_Producto sp
    LEFT JOIN (
        SELECT 
            IDITEM, 
            CantidadDisponible,
            EntradaInventario,
            SalidaInventario,
            ROW_NUMBER() OVER (PARTITION BY IDITEM ORDER BY IDInventario DESC) AS rn
        FROM Inventario
    ) inv_ultimo ON sp.IDITEM = inv_ultimo.IDITEM AND inv_ultimo.rn = 1
    WHERE sp.Tipo = 'Producto'
    ORDER BY sp.NombreProducto;
END;

------------------------------------
CREATE PROCEDURE ObtenerDetalleProductoServicio
    @IDITEM INT
AS
BEGIN
    SELECT sp.*, 
        CASE 
            WHEN sp.Tipo = 'Producto' THEN ISNULL(i.CantidadDisponible, 0)
            ELSE NULL
        END AS CantidadDisponible
    FROM Servicio_Producto sp
    LEFT JOIN (
        SELECT IDITEM, CantidadDisponible,
               ROW_NUMBER() OVER (PARTITION BY IDITEM ORDER BY IDInventario DESC) AS rn
        FROM Inventario
    ) i ON sp.IDITEM = i.IDITEM AND i.rn = 1
    WHERE sp.IDITEM = @IDITEM
END

------------------------------------
-- Procedimiento para obtener reporte de inventario para Excel
CREATE PROCEDURE ObtenerReporteInventario
AS
BEGIN
    SELECT 
        sp.IDITEM as 'C�digo',
        sp.NombreProducto as 'Producto',
        sp.PrecioITEM as 'Precio Unitario',
        ISNULL(i.CantidadDisponible, 0) as 'Cantidad Disponible',
        (sp.PrecioITEM * ISNULL(i.CantidadDisponible, 0)) as 'Valor Total'
    FROM Servicio_Producto sp
    LEFT JOIN (
        SELECT IDITEM, CantidadDisponible,
        ROW_NUMBER() OVER (PARTITION BY IDITEM ORDER BY IDInventario DESC) as rn
        FROM Inventario
    ) i ON sp.IDITEM = i.IDITEM AND i.rn = 1
    WHERE sp.Tipo = 'Producto'
    ORDER BY sp.NombreProducto;
END;

------------------------------------------------------------------------------

--PROCEDIMIENTO PARA AGREGAR PRODUCTO
-- ========================================
CREATE PROCEDURE AgregarProducto
    @Codigo NVARCHAR(50),
    @Nombre NVARCHAR(100),
    @Precio MONEY,
    @Stock INT
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Verificar si ya existe el c�digo
        IF EXISTS (SELECT 1 FROM Servicio_Producto WHERE IDITEM = @Codigo)
        BEGIN
            RAISERROR('Ya existe un producto con ese c�digo', 16, 1);
            RETURN;
        END
        
        -- Insertar en Servicio_Producto (necesitamos usar IDENTITY_INSERT si queremos c�digo personalizado)
        DECLARE @NewID INT;
        
        INSERT INTO Servicio_Producto (NombreProducto, Tipo, PrecioITEM)
        VALUES (@Nombre, 'Producto', @Precio);
        
        SET @NewID = SCOPE_IDENTITY();
        
        -- Insertar en Inventario con el stock inicial
        INSERT INTO Inventario (IDITEM, EntradaInventario, SalidaInventario, CantidadDisponible)
        VALUES (@NewID, @Stock, 0, @Stock);
        
        COMMIT TRANSACTION;
        
        SELECT @NewID as NuevoID, 'Producto agregado exitosamente' as Mensaje;
        
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;
GO
----------------------------------------------------------------------
--PROCEDIMIENTO PARA ELIMINAR PRODUCTO
-- ========================================
CREATE PROCEDURE EliminarProducto
    @IDITEM INT
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Verificar si el producto existe
        IF NOT EXISTS (SELECT 1 FROM Servicio_Producto WHERE IDITEM = @IDITEM)
        BEGIN
            RAISERROR('El producto no existe', 16, 1);
            RETURN;
        END
        
        -- Verificar si tiene movimientos en ventas
        IF EXISTS (SELECT 1 FROM Venta WHERE IDITEM = @IDITEM)
        BEGIN
            RAISERROR('No se puede eliminar el producto porque tiene movimientos registrados', 16, 1);
            RETURN;
        END
        
        -- Eliminar del inventario primero
        DELETE FROM Inventario WHERE IDITEM = @IDITEM;
        
        -- Eliminar del cat�logo de productos
        DELETE FROM Servicio_Producto WHERE IDITEM = @IDITEM;
        
        COMMIT TRANSACTION;
        
        SELECT 'Producto eliminado exitosamente' as Mensaje;
        
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;
GO
--------------------------------------------------------
-- PROCEDIMIENTO PARA VERIFICAR C�DIGO DE PRODUCTO
-- ================================================
CREATE PROCEDURE VerificarCodigoProducto
    @Codigo NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        CASE 
            WHEN EXISTS (SELECT 1 FROM Servicio_Producto WHERE IDITEM = @Codigo)
            THEN 1 
            ELSE 0 
        END as Existe;
END;
GO
----------------------------------------------------------------------------
-------------------------------------------------------------------
--PROCEDIMIENTO PARA BUSCAR PRODUCTOS
-- =====================================
CREATE PROCEDURE BuscarProductos
    @Termino NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        sp.IDITEM,
        sp.NombreProducto,
        sp.PrecioITEM,
        sp.Tipo,
        ISNULL(i.CantidadDisponible, 0) as CantidadDisponible
    FROM Servicio_Producto sp
    LEFT JOIN Inventario i ON sp.IDITEM = i.IDITEM
    WHERE sp.Tipo = 'Producto'
      AND (sp.NombreProducto LIKE '%' + @Termino + '%' 
           OR CAST(sp.IDITEM as NVARCHAR) LIKE '%' + @Termino + '%')
    ORDER BY sp.NombreProducto;
END;
GO
-------------------------------------------------------------
--PROCEDIMIENTO PARA OBTENER PRODUCTO POR ID
-- ============================================
CREATE PROCEDURE ObtenerProductoPorId
    @IDITEM INT
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        sp.IDITEM,
        sp.NombreProducto,
        sp.PrecioITEM,
        sp.Tipo,
        ISNULL(i.CantidadDisponible, 0) as CantidadDisponible,
        ISNULL(i.EntradaInventario, 0) as EntradaInventario,
        ISNULL(i.SalidaInventario, 0) as SalidaInventario
    FROM Servicio_Producto sp
    LEFT JOIN Inventario i ON sp.IDITEM = i.IDITEM
    WHERE sp.IDITEM = @IDITEM;
END;
GO
-------------------------------------------------------------------
-- PROCEDIMIENTOS ALMACENADOS PARA GESTI�N DE SERVICIOS
-- ====================================================

-- 1. PROCEDIMIENTO PARA AGREGAR SERVICIO
CREATE OR ALTER PROCEDURE AgregarServicio
    @Codigo NVARCHAR(50),
    @Nombre NVARCHAR(100),
    @Precio MONEY
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Verificar si ya existe un servicio con el mismo c�digo
        -- Buscamos por el c�digo que est� al inicio del nombre
        IF EXISTS (SELECT 1 FROM Servicio_Producto 
                  WHERE NombreProducto LIKE @Codigo + ' -%' AND Tipo = 'Servicio')
        BEGIN
            RAISERROR('Ya existe un servicio con ese c�digo', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END
        
        -- Insertar el servicio
        -- Guardamos el c�digo como parte del nombre para poder identificarlo despu�s
        DECLARE @NombreCompleto NVARCHAR(200) = @Codigo + ' - ' + @Nombre;
        
        INSERT INTO Servicio_Producto (NombreProducto, Tipo, PrecioITEM)
        VALUES (@NombreCompleto, 'Servicio', @Precio);
        
        -- Obtener el ID generado autom�ticamente
        DECLARE @NuevoID INT = SCOPE_IDENTITY();
        
        COMMIT TRANSACTION;
        
        SELECT @NuevoID as NuevoID, @Codigo as CodigoUtilizado, 'Servicio agregado exitosamente' as Mensaje;
        
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage, 16, 1);
    END CATCH
END;
GO
-----------------------------------------------------------------------------------
-- 2. PROCEDIMIENTO PARA VERIFICAR C�DIGO
CREATE OR ALTER PROCEDURE VerificarCodigoServicio
    @Codigo NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        CASE 
            WHEN EXISTS (SELECT 1 FROM Servicio_Producto 
                        WHERE NombreProducto LIKE @Codigo + ' -%' AND Tipo = 'Servicio')
            THEN 1 
            ELSE 0 
        END as Existe;
END;
GO
-------------------------------------------------------------------------------------
-- 3. PROCEDIMIENTO PARA OBTENER SERVICIOS
CREATE OR ALTER PROCEDURE ObtenerServicios
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        IDITEM,
        -- Extraer el c�digo del nombre (parte antes del ' - ')
        CASE 
            WHEN CHARINDEX(' - ', NombreProducto) > 0 
            THEN LEFT(NombreProducto, CHARINDEX(' - ', NombreProducto) - 1)
            ELSE CAST(IDITEM AS NVARCHAR)
        END as CodigoDisplay,
        -- Extraer solo el nombre (parte despu�s del ' - ')
        CASE 
            WHEN CHARINDEX(' - ', NombreProducto) > 0 
            THEN SUBSTRING(NombreProducto, CHARINDEX(' - ', NombreProducto) + 3, LEN(NombreProducto))
            ELSE NombreProducto
        END as NombreServicio,
        NombreProducto as NombreCompleto,
        PrecioITEM,
        Tipo
    FROM Servicio_Producto 
    WHERE Tipo = 'Servicio'
    ORDER BY NombreProducto;
END;
GO
-----------------------------------------------------------------------
-- 4. PROCEDIMIENTO PARA BUSCAR SERVICIOS
CREATE OR ALTER PROCEDURE BuscarServicios
    @Termino NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        IDITEM,
        -- Extraer el c�digo del nombre
        CASE 
            WHEN CHARINDEX(' - ', NombreProducto) > 0 
            THEN LEFT(NombreProducto, CHARINDEX(' - ', NombreProducto) - 1)
            ELSE CAST(IDITEM AS NVARCHAR)
        END as CodigoDisplay,
        -- Extraer solo el nombre
        CASE 
            WHEN CHARINDEX(' - ', NombreProducto) > 0 
            THEN SUBSTRING(NombreProducto, CHARINDEX(' - ', NombreProducto) + 3, LEN(NombreProducto))
            ELSE NombreProducto
        END as NombreServicio,
        NombreProducto as NombreCompleto,
        PrecioITEM,
        Tipo
    FROM Servicio_Producto 
    WHERE Tipo = 'Servicio'
      AND (NombreProducto LIKE '%' + @Termino + '%' 
           OR CAST(IDITEM as NVARCHAR) LIKE '%' + @Termino + '%')
    ORDER BY NombreProducto;
END;
GO
---------------------------------------------------------------
-- 5. PROCEDIMIENTO PARA OBTENER SERVICIO POR ID
CREATE OR ALTER PROCEDURE ObtenerServicioPorId
    @IDITEM INT
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        IDITEM,
        -- Extraer el c�digo del nombre
        CASE 
            WHEN CHARINDEX(' - ', NombreProducto) > 0 
            THEN LEFT(NombreProducto, CHARINDEX(' - ', NombreProducto) - 1)
            ELSE CAST(IDITEM AS NVARCHAR)
        END as CodigoDisplay,
        -- Extraer solo el nombre
        CASE 
            WHEN CHARINDEX(' - ', NombreProducto) > 0 
            THEN SUBSTRING(NombreProducto, CHARINDEX(' - ', NombreProducto) + 3, LEN(NombreProducto))
            ELSE NombreProducto
        END as NombreServicio,
        NombreProducto as NombreCompleto,
        PrecioITEM,
        Tipo
    FROM Servicio_Producto 
    WHERE IDITEM = @IDITEM AND Tipo = 'Servicio';
END;
GO
---------------------------------------------------------
-- 6. PROCEDIMIENTO PARA ELIMINAR SERVICIO - CORREGIDO SIN DEPENDENCIAS EXTERNAS
CREATE OR ALTER PROCEDURE EliminarServicio
    @IDITEM INT
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Verificar si el servicio existe
        IF NOT EXISTS (SELECT 1 FROM Servicio_Producto WHERE IDITEM = @IDITEM AND Tipo = 'Servicio')
        BEGIN
            RAISERROR('El servicio no existe', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END
        -- Eliminar el servicio
        DELETE FROM Servicio_Producto 
        WHERE IDITEM = @IDITEM AND Tipo = 'Servicio';
        
        -- Verificar si se elimin� alguna fila
        IF @@ROWCOUNT = 0
        BEGIN
            RAISERROR('No se pudo eliminar el servicio', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END
        
        COMMIT TRANSACTION;
        
        SELECT 'Servicio eliminado exitosamente' as Mensaje;
        
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();
        
        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;
GO
---------------------------------------------------------
-- 7. PROCEDIMIENTO ADICIONAL PARA OBTENER ESTAD�STICAS
CREATE OR ALTER PROCEDURE ObtenerEstadisticasServicios
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        COUNT(*) as TotalServicios,
        AVG(CAST(PrecioITEM as FLOAT)) as PrecioPromedio,
        MIN(PrecioITEM) as PrecioMinimo,
        MAX(PrecioITEM) as PrecioMaximo,
        SUM(CASE WHEN PrecioITEM > 0 THEN 1 ELSE 0 END) as ServiciosConPrecio
    FROM Servicio_Producto 
    WHERE Tipo = 'Servicio';
END;
GO


--------------------------------------------------------
----------------------------------------------------------
-- Procedimiento para obtener todos los productos y servicios con disponibilidad
CREATE PROCEDURE ObtenerProductosServiciosUsuario
AS
BEGIN
    SET NOCOUNT ON;
    
    -- CTE para obtener la cantidad disponible m�s reciente de cada producto
    WITH UltimoInventario AS (
        SELECT 
            i.IDITEM,
            i.CantidadDisponible,
            ROW_NUMBER() OVER (PARTITION BY i.IDITEM ORDER BY i.IDInventario DESC) as rn
        FROM Inventario i
    )
    SELECT 
        sp.IDITEM,
        sp.NombreProducto,
        sp.Tipo,
        sp.PrecioITEM,
        CASE 
            WHEN sp.Tipo = 'Producto' THEN ISNULL(ui.CantidadDisponible, 0)
            ELSE NULL -- Los servicios no tienen cantidad limitada
        END AS CantidadDisponible,
        CASE 
            WHEN sp.Tipo = 'Producto' THEN 
                CASE 
                    WHEN ISNULL(ui.CantidadDisponible, 0) > 0 THEN 'Disponible'
                    ELSE 'Agotado'
                END
            ELSE 'Disponible' -- Los servicios siempre est�n disponibles
        END AS EstadoDisponibilidad
    FROM Servicio_Producto sp
    LEFT JOIN UltimoInventario ui ON sp.IDITEM = ui.IDITEM AND ui.rn = 1
    ORDER BY sp.Tipo, sp.NombreProducto;
END;

-- Procedimiento para buscar productos y servicios con filtros
CREATE PROCEDURE BuscarProductosServiciosUsuario
    @Termino NVARCHAR(100) = '',
    @Tipo NVARCHAR(50) = ''
AS
BEGIN
    SET NOCOUNT ON;
    
    -- CTE para obtener la cantidad disponible m�s reciente de cada producto
    WITH UltimoInventario AS (
        SELECT 
            i.IDITEM,
            i.CantidadDisponible,
            ROW_NUMBER() OVER (PARTITION BY i.IDITEM ORDER BY i.IDInventario DESC) as rn
        FROM Inventario i
    )
    SELECT 
        sp.IDITEM,
        sp.NombreProducto,
        sp.Tipo,
        sp.PrecioITEM,
        CASE 
            WHEN sp.Tipo = 'Producto' THEN ISNULL(ui.CantidadDisponible, 0)
            ELSE NULL
        END AS CantidadDisponible,
        CASE 
            WHEN sp.Tipo = 'Producto' THEN 
                CASE 
                    WHEN ISNULL(ui.CantidadDisponible, 0) > 0 THEN 'Disponible'
                    ELSE 'Agotado'
                END
            ELSE 'Disponible'
        END AS EstadoDisponibilidad
    FROM Servicio_Producto sp
    LEFT JOIN UltimoInventario ui ON sp.IDITEM = ui.IDITEM AND ui.rn = 1
    WHERE 
        (@Termino = '' OR sp.NombreProducto LIKE '%' + @Termino + '%')
        AND (@Tipo = '' OR sp.Tipo = @Tipo)
    ORDER BY sp.Tipo, sp.NombreProducto;
END;

-- Procedimiento para obtener detalles de un producto o servicio espec�fico
CREATE PROCEDURE ObtenerDetalleProductoServicioUsuario
    @IDITEM INT
AS
BEGIN
    SET NOCOUNT ON;
    
    -- CTE para obtener la cantidad disponible m�s reciente del producto espec�fico
    WITH UltimoInventario AS (
        SELECT 
            i.IDITEM,
            i.CantidadDisponible,
            ROW_NUMBER() OVER (PARTITION BY i.IDITEM ORDER BY i.IDInventario DESC) as rn
        FROM Inventario i
        WHERE i.IDITEM = @IDITEM
    )
    SELECT 
        sp.IDITEM,
        sp.NombreProducto,
        sp.Tipo,
        sp.PrecioITEM,
        CASE 
            WHEN sp.Tipo = 'Producto' THEN ISNULL(ui.CantidadDisponible, 0)
            ELSE NULL
        END AS CantidadDisponible,
        CASE 
            WHEN sp.Tipo = 'Producto' THEN 
                CASE 
                    WHEN ISNULL(ui.CantidadDisponible, 0) > 0 THEN 'Disponible'
                    ELSE 'Agotado'
                END
            ELSE 'Disponible'
        END AS EstadoDisponibilidad
    FROM Servicio_Producto sp
    LEFT JOIN UltimoInventario ui ON sp.IDITEM = ui.IDITEM AND ui.rn = 1
    WHERE sp.IDITEM = @IDITEM;
END;

------------
------------------------------citass wiiiiiiiii-------------------------------
-------------------------------------------------------------------
-----------------------------------------------------------------------------
-- ============================================
-- SISTEMA DE CITAS - CLINIPET
-- Procedimientos Almacenados
-- ============================================

-- 1. CREAR TABLA CITA
CREATE TABLE Cita (
    IDCita INT IDENTITY(1,1) PRIMARY KEY,
    CedulaCliente NVARCHAR(20) NOT NULL FOREIGN KEY REFERENCES Cliente(Cedula),
    IDMascota INT NOT NULL FOREIGN KEY REFERENCES Mascota(IDMascota),
    FechaCita DATE NOT NULL,
    HoraCita TIME NOT NULL,
    EstadoCita NVARCHAR(20) DEFAULT 'Pendiente' CHECK (EstadoCita IN ('Pendiente', 'Confirmada', 'Cancelada', 'Completada', 'No Show')),
    TipoServicio NVARCHAR(100),
    Observaciones NVARCHAR(500),
    FechaCreacion DATETIME DEFAULT GETDATE(),
    UsuarioCreador INT FOREIGN KEY REFERENCES Usuarios(UsuarioID),
    FechaConfirmacion DATETIME NULL,
    MotivoCancelacion NVARCHAR(255) NULL
);

-- ============================================
-- 1. PROCEDIMIENTO PARA CREAR CITA
-- ============================================
CREATE PROCEDURE CrearCita
    @CedulaCliente NVARCHAR(20),
    @IDMascota INT,
    @FechaCita DATE,
    @HoraCita TIME,
    @TipoServicio NVARCHAR(100),
    @Observaciones NVARCHAR(500) = NULL,
    @UsuarioCreador INT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;

        -- Validar que el cliente existe
        IF NOT EXISTS (SELECT 1 FROM Cliente WHERE Cedula = @CedulaCliente)
        BEGIN
            RAISERROR('El cliente no existe.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        -- Validar que la mascota existe y pertenece al cliente
        IF NOT EXISTS (SELECT 1 FROM Mascota WHERE IDMascota = @IDMascota AND CedulaCliente = @CedulaCliente)
        BEGIN
            RAISERROR('La mascota no existe o no pertenece a este cliente.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        -- Validar que la fecha no sea en el pasado
        IF @FechaCita < CAST(GETDATE() AS DATE)
        BEGIN
            RAISERROR('La fecha de la cita no puede ser en el pasado.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        -- Validar horario de atenci�n (8:00 AM a 6:00 PM)
        IF @HoraCita < '08:00:00' OR @HoraCita > '18:00:00'
        BEGIN
            RAISERROR('Horario fuera del rango de atenci�n (8:00 AM - 6:00 PM).', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        -- Validar que no hay otra cita en la misma fecha y hora
        IF EXISTS (SELECT 1 FROM Cita 
                  WHERE FechaCita = @FechaCita 
                  AND HoraCita = @HoraCita 
                  AND EstadoCita NOT IN ('Cancelada'))
        BEGIN
            RAISERROR('Ya existe una cita programada para esa fecha y hora.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        -- Insertar la cita
        INSERT INTO Cita (CedulaCliente, IDMascota, FechaCita, HoraCita, TipoServicio, Observaciones, UsuarioCreador)
        VALUES (@CedulaCliente, @IDMascota, @FechaCita, @HoraCita, @TipoServicio, @Observaciones, @UsuarioCreador);

        DECLARE @IDCita INT = SCOPE_IDENTITY();

        COMMIT TRANSACTION;
        
        SELECT @IDCita AS IDCita, 'Cita creada exitosamente' AS Mensaje;

    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage, 16, 1);
    END CATCH
END;
GO

-- ============================================
-- 2. OBTENER CITAS POR CLIENTE
-- ============================================
CREATE PROCEDURE ObtenerCitasPorCliente
    @CedulaCliente NVARCHAR(20)
AS
BEGIN
    SELECT 
        c.IDCita,
        c.FechaCita,
        c.HoraCita,
        c.EstadoCita,
        c.TipoServicio,
        c.Observaciones,
        c.FechaCreacion,
        m.Nombre AS NombreMascota,
        m.Especie,
        cl.Nombre AS NombreCliente
    FROM Cita c
    INNER JOIN Mascota m ON c.IDMascota = m.IDMascota
    INNER JOIN Cliente cl ON c.CedulaCliente = cl.Cedula
    WHERE c.CedulaCliente = @CedulaCliente
    ORDER BY c.FechaCita DESC, c.HoraCita DESC;
END;
GO

-- ============================================
-- 3. OBTENER CITAS POR FECHA
-- ============================================
CREATE PROCEDURE ObtenerCitasPorFecha
    @FechaInicio DATE,
    @FechaFin DATE = NULL
AS
BEGIN
    IF @FechaFin IS NULL
        SET @FechaFin = @FechaInicio;

    SELECT 
        c.IDCita,
        c.FechaCita,
        c.HoraCita,
        c.EstadoCita,
        c.TipoServicio,
        c.Observaciones,
        cl.Nombre AS NombreCliente,
        cl.Cedula,
        cl.Tel�fono,
        m.Nombre AS NombreMascota,
        m.Especie,
        u.NombreCompleto AS CreadoPor
    FROM Cita c
    INNER JOIN Cliente cl ON c.CedulaCliente = cl.Cedula
    INNER JOIN Mascota m ON c.IDMascota = m.IDMascota
    LEFT JOIN Usuarios u ON c.UsuarioCreador = u.UsuarioID
    WHERE c.FechaCita BETWEEN @FechaInicio AND @FechaFin
    ORDER BY c.FechaCita, c.HoraCita;
END;
GO

-- ============================================
-- 4. ACTUALIZAR ESTADO DE CITA
-- ============================================
CREATE PROCEDURE ActualizarEstadoCita
    @IDCita INT,
    @NuevoEstado NVARCHAR(20),
    @MotivoCancelacion NVARCHAR(255) = NULL,
    @UsuarioModificador INT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        -- Validar que la cita existe
        IF NOT EXISTS (SELECT 1 FROM Cita WHERE IDCita = @IDCita)
        BEGIN
            RAISERROR('La cita no existe.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        -- Validar estado v�lido
        IF @NuevoEstado NOT IN ('Pendiente', 'Confirmada', 'Cancelada', 'Completada', 'No Show')
        BEGIN
            RAISERROR('Estado de cita no v�lido.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        -- Actualizar la cita
        UPDATE Cita 
        SET EstadoCita = @NuevoEstado,
            FechaConfirmacion = CASE WHEN @NuevoEstado = 'Confirmada' THEN GETDATE() ELSE FechaConfirmacion END,
            MotivoCancelacion = CASE WHEN @NuevoEstado = 'Cancelada' THEN @MotivoCancelacion ELSE NULL END
        WHERE IDCita = @IDCita;

        COMMIT TRANSACTION;
        
        SELECT 'Estado de cita actualizado exitosamente' AS Mensaje;

    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;
GO

-- ============================================
-- 5. REAGENDAR CITA
-- ============================================
CREATE PROCEDURE ReagendarCita
    @IDCita INT,
    @NuevaFecha DATE,
    @NuevaHora TIME,
    @UsuarioModificador INT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        -- Validar que la cita existe
        IF NOT EXISTS (SELECT 1 FROM Cita WHERE IDCita = @IDCita)
        BEGIN
            RAISERROR('La cita no existe.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        -- Validar que la nueva fecha no sea en el pasado
        IF @NuevaFecha < CAST(GETDATE() AS DATE)
        BEGIN
            RAISERROR('La nueva fecha no puede ser en el pasado.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        -- Validar horario de atenci�n
        IF @NuevaHora < '08:00:00' OR @NuevaHora > '18:00:00'
        BEGIN
            RAISERROR('Horario fuera del rango de atenci�n (8:00 AM - 6:00 PM).', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        -- Validar disponibilidad del nuevo horario
        IF EXISTS (SELECT 1 FROM Cita 
                  WHERE FechaCita = @NuevaFecha 
                  AND HoraCita = @NuevaHora 
                  AND EstadoCita NOT IN ('Cancelada')
                  AND IDCita != @IDCita)
        BEGIN
            RAISERROR('Ya existe una cita programada para esa fecha y hora.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        -- Actualizar la cita
        UPDATE Cita 
        SET FechaCita = @NuevaFecha,
            HoraCita = @NuevaHora,
            EstadoCita = 'Pendiente'  -- Volver a estado pendiente al reagendar
        WHERE IDCita = @IDCita;

        COMMIT TRANSACTION;
        
        SELECT 'Cita reagendada exitosamente' AS Mensaje;

    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;
GO

-- ============================================
-- 6. OBTENER DISPONIBILIDAD DE HORARIOS
-- ============================================
CREATE PROCEDURE ObtenerDisponibilidadHorarios
    @Fecha DATE
AS
BEGIN
    -- Crear tabla temporal con todos los horarios del d�a
    DECLARE @HorariosDisponibles TABLE (
        Hora TIME,
        Disponible BIT
    );

    -- Insertar horarios de 8:00 AM a 6:00 PM cada 30 minutos
    DECLARE @HoraActual TIME = '08:00:00';
    
    WHILE @HoraActual <= '18:00:00'
    BEGIN
        INSERT INTO @HorariosDisponibles (Hora, Disponible)
        SELECT @HoraActual, 
               CASE WHEN EXISTS (SELECT 1 FROM Cita 
                               WHERE FechaCita = @Fecha 
                               AND HoraCita = @HoraActual 
                               AND EstadoCita NOT IN ('Cancelada'))
                    THEN 0 ELSE 1 END;
        
        SET @HoraActual = DATEADD(MINUTE, 30, @HoraActual);
    END

    SELECT * FROM @HorariosDisponibles ORDER BY Hora;
END;
GO

-- ============================================
-- 7. OBTENER CITAS PENDIENTES DE CONFIRMACI�N
-- ============================================
CREATE PROCEDURE ObtenerCitasPendientesConfirmacion
AS
BEGIN
    SELECT 
        c.IDCita,
        c.FechaCita,
        c.HoraCita,
        cl.Nombre AS NombreCliente,
        cl.Email,
        cl.Tel�fono,
        m.Nombre AS NombreMascota,
        c.TipoServicio,
        DATEDIFF(HOUR, c.FechaCreacion, GETDATE()) AS HorasDesdeCreacion
    FROM Cita c
    INNER JOIN Cliente cl ON c.CedulaCliente = cl.Cedula
    INNER JOIN Mascota m ON c.IDMascota = m.IDMascota
    WHERE c.EstadoCita = 'Pendiente'
    AND c.FechaCita >= CAST(GETDATE() AS DATE)
    ORDER BY c.FechaCita, c.HoraCita;
END;
GO

-- ============================================
-- 8. OBTENER DETALLES DE CITA
-- ============================================
CREATE PROCEDURE ObtenerDetalleCita
    @IDCita INT
AS
BEGIN
    SELECT 
        c.IDCita,
        c.FechaCita,
        c.HoraCita,
        c.EstadoCita,
        c.TipoServicio,
        c.Observaciones,
        c.FechaCreacion,
        c.FechaConfirmacion,
        c.MotivoCancelacion,
        cl.Cedula,
        cl.Nombre AS NombreCliente,
        cl.Tel�fono,
        cl.Email,
        cl.Direcci�n,
        m.IDMascota,
        m.Nombre AS NombreMascota,
        m.Especie,
        m.Peso,
        m.Edad,
        r.Nombre AS RazaMascota,
        u.NombreCompleto AS CreadoPor
    FROM Cita c
    INNER JOIN Cliente cl ON c.CedulaCliente = cl.Cedula
    INNER JOIN Mascota m ON c.IDMascota = m.IDMascota
    LEFT JOIN Raza r ON m.RazaID = r.RazaID
    LEFT JOIN Usuarios u ON c.UsuarioCreador = u.UsuarioID
    WHERE c.IDCita = @IDCita;
END;
GO

-- ============================================
-- 9. REPORTES Y ESTAD�STICAS
-- ============================================
CREATE PROCEDURE ObtenerEstadisticasCitas
    @FechaInicio DATE,
    @FechaFin DATE
AS
BEGIN
    SELECT 
        COUNT(*) AS TotalCitas,
        SUM(CASE WHEN EstadoCita = 'Confirmada' THEN 1 ELSE 0 END) AS CitasConfirmadas,
        SUM(CASE WHEN EstadoCita = 'Completada' THEN 1 ELSE 0 END) AS CitasCompletadas,
        SUM(CASE WHEN EstadoCita = 'Cancelada' THEN 1 ELSE 0 END) AS CitasCanceladas,
        SUM(CASE WHEN EstadoCita = 'No Show' THEN 1 ELSE 0 END) AS NoShow,
        SUM(CASE WHEN EstadoCita = 'Pendiente' THEN 1 ELSE 0 END) AS CitasPendientes
    FROM Cita
    WHERE FechaCita BETWEEN @FechaInicio AND @FechaFin;
END;
GO


--------------------------------------------------------------------------------------------------
-- PROCEDIMIENTOS ALMACENADOS PARA FIRMA DIGITAL - CORREGIDOS





CREATE TABLE ClavesDigitales (
    ID INT PRIMARY KEY IDENTITY(1,1),
    UsuarioID INT NOT NULL,
    ClavePublica TEXT NOT NULL,
    ClavePrivadaCifrada TEXT NOT NULL,
    PasswordHash NVARCHAR(255) NOT NULL,
    FechaGeneracion DATETIME DEFAULT GETDATE(),
    Activa BIT DEFAULT 1,
    Fingerprint NVARCHAR(32) NOT NULL,
    FOREIGN KEY (UsuarioID) REFERENCES Usuarios(UsuarioID)
);

-- ============================================

-- 1. Modificar la tabla Factura para incluir la firma digital
ALTER TABLE Factura ADD FirmaDigital VARBINARY(MAX) NULL;
ALTER TABLE Factura ALTER COLUMN FirmaDigital NVARCHAR(MAX) NULL;

-- 2. Procedimiento mejorado para generar factura con firma
ALTER PROCEDURE GenerarFactura
    @CedulaCliente NVARCHAR(20),
    @IDMascota INT = NULL,
    @UsuarioFirma INT,
    @FirmaDigital VARBINARY(MAX) = NULL -- Nuevo par�metro para la firma
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        -- Validar existencia del cliente
        IF NOT EXISTS (SELECT 1 FROM Cliente WHERE Cedula = @CedulaCliente)
        BEGIN
            RAISERROR ('El cliente no existe.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        -- Validar que el usuario existe y est� activo
        IF NOT EXISTS (SELECT 1 FROM Usuarios WHERE UsuarioID = @UsuarioFirma AND Activo = 1)
        BEGIN
            RAISERROR ('Usuario no v�lido para firmar factura.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        -- Insertar la factura CON LA FIRMA DIGITAL
        INSERT INTO Factura (IDMascota, CedulaCliente, Fecha, UsuarioFirma, FechaFirma, FirmaDigital)
        VALUES (@IDMascota, @CedulaCliente, GETDATE(), @UsuarioFirma, GETDATE(), @FirmaDigital);

        -- Obtener el ID de la factura reci�n insertada
        DECLARE @IDFactura INT = SCOPE_IDENTITY();

        -- Confirmar transacci�n
        COMMIT TRANSACTION;
        
        -- Devolver el ID de la factura para poder almacenar en tabla venta
        SELECT @IDFactura AS IDFactura;
        
    END TRY
    BEGIN CATCH
        -- Manejo de errores
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;
GO

-- 3. Procedimiento mejorado para obtener factura con informaci�n de firma
ALTER PROCEDURE ObtenerFacturaConFirma
    @IDFactura INT
AS
BEGIN
    SELECT 
        f.IDFactura,
        f.CedulaCliente,
        c.Nombre AS NombreCliente,
        f.IDMascota,
        m.Nombre AS NombreMascota,
        f.Fecha AS FechaFactura,
        f.subtotalf,
        f.ITBMSFactura,
        f.totalFactura,
        -- INFORMACI�N DE LA FIRMA
        f.UsuarioFirma,
        u.NombreCompleto AS NombreFirmante,
        u.NombreUsuario AS UsuarioFirmante,
        r.NombreRol AS RolFirmante,
        f.FechaFirma,
        f.FirmaDigital,
        -- Determinar si tiene firma v�lida (se verificar� en PHP)
        CASE WHEN f.FirmaDigital IS NOT NULL THEN 1 ELSE 0 END AS TieneFirmaDigital
    FROM Factura f
    INNER JOIN Cliente c ON f.CedulaCliente = c.Cedula
    LEFT JOIN Mascota m ON f.IDMascota = m.IDMascota
    INNER JOIN Usuarios u ON f.UsuarioFirma = u.UsuarioID
    INNER JOIN Roles r ON u.RolID = r.RolID
    WHERE f.IDFactura = @IDFactura;
END;
GO

-- 4. Corregir el procedimiento UsuarioTieneClaves
CREATE OR ALTER PROCEDURE UsuarioTieneClaves
    @UsuarioID INT
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @TieneClaves BIT;
    
    SELECT @TieneClaves = CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END
    FROM ClavesDigitales 
    WHERE UsuarioID = @UsuarioID AND Activa = 1;
    
    SELECT @TieneClaves AS TieneClaves;
END;
GO

-- 5. Mejorar el procedimiento GuardarClavesUsuario
CREATE OR ALTER PROCEDURE GuardarClavesUsuario
    @UsuarioID INT,
    @ClavePublica TEXT,
    @ClavePrivadaCifrada TEXT,
    @PasswordHash NVARCHAR(255),
    @Fingerprint NVARCHAR(32)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Desactivar claves anteriores
        UPDATE ClavesDigitales 
        SET Activa = 0 
        WHERE UsuarioID = @UsuarioID;
        
        -- Insertar nuevas claves
        INSERT INTO ClavesDigitales (UsuarioID, ClavePublica, ClavePrivadaCifrada, PasswordHash, Fingerprint, Activa)
        VALUES (@UsuarioID, @ClavePublica, @ClavePrivadaCifrada, @PasswordHash, @Fingerprint, 1);
        
        COMMIT TRANSACTION;
        
        -- Retornar �xito
        SELECT 1 AS Exito, 'Claves guardadas exitosamente' AS Mensaje;
        
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        
        -- Retornar error
        SELECT 0 AS Exito, ERROR_MESSAGE() AS Mensaje;
    END CATCH
END;
GO

-- 6. Procedimiento para obtener claves mejorado
CREATE OR ALTER PROCEDURE ObtenerClavesUsuario
    @UsuarioID INT
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        ClavePublica,
        ClavePrivadaCifrada,
        PasswordHash,
        Fingerprint,
        FechaGeneracion
    FROM ClavesDigitales 
    WHERE UsuarioID = @UsuarioID AND Activa = 1;
END;
GO

-- 7. Procedimiento para regenerar claves
CREATE OR ALTER PROCEDURE RegenerarClavesUsuario
    @UsuarioID INT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Verificar que el usuario existe
        IF NOT EXISTS (SELECT 1 FROM Usuarios WHERE UsuarioID = @UsuarioID AND Activo = 1)
        BEGIN
            RAISERROR('Usuario no encontrado o inactivo', 16, 1);
            RETURN;
        END
        
        -- Desactivar todas las claves existentes del usuario
        UPDATE ClavesDigitales 
        SET Activa = 0 
        WHERE UsuarioID = @UsuarioID;
        
        COMMIT TRANSACTION;
        
        -- Retornar �xito para que PHP genere nuevas claves
        SELECT 1 AS Exito, 'Claves anteriores desactivadas. Listo para generar nuevas claves.' AS Mensaje;
        
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        SELECT 0 AS Exito, ERROR_MESSAGE() AS Mensaje;
    END CATCH
END;
GO

-- 8. Insertar datos de prueba para testing
-- Solo ejecutar si no existen usuarios de prueba
IF NOT EXISTS (SELECT 1 FROM Usuarios WHERE NombreUsuario = 'admin')
BEGIN
    -- Crear usuario admin de prueba
    INSERT INTO Usuarios (NombreUsuario, Email, PasswordHash, NombreCompleto, RolID, Activo)
    VALUES ('admin', 'admin@clinipet.com', '$2y$10$example_hash_here', 'Administrador Sistema', 1, 1);
END

IF NOT EXISTS (SELECT 1 FROM Usuarios WHERE NombreUsuario = 'operador1')
BEGIN
    -- Crear usuario operador de prueba
    INSERT INTO Usuarios (NombreUsuario, Email, PasswordHash, NombreCompleto, RolID, Activo)
    VALUES ('operador1', 'operador@clinipet.com', '$2y$10$example_hash_here', 'Operador Veterinario', 2, 1);
END


-- Agregar columna para firma digital en la tabla Factura
ALTER TABLE Factura ADD FirmaDigital NVARCHAR(MAX) NULL;

-- Crear tabla para almacenar claves digitales de usuarios (opcional, para OpenSSL completo)
CREATE TABLE ClavesDigitales (
    ClaveID INT IDENTITY(1,1) PRIMARY KEY,
    UsuarioID INT NOT NULL,
    ClavePublica NVARCHAR(MAX) NOT NULL,
    ClavePrivadaCifrada NVARCHAR(MAX) NOT NULL,
    PasswordHash NVARCHAR(255) NOT NULL,
    Fingerprint NVARCHAR(64) NOT NULL,
    FechaGeneracion DATETIME DEFAULT GETDATE(),
    Activa BIT DEFAULT 1,
    FOREIGN KEY (UsuarioID) REFERENCES Usuarios(UsuarioID),
    INDEX IX_Usuario_Activa (UsuarioID, Activa)
);



USE [CliniPet]
GO

/****** Object:  StoredProcedure [dbo].[UsuarioTieneClaves]    Script Date: 07/28/2025 12:22:04 p.�m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER   PROCEDURE [dbo].[UsuarioTieneClaves]
    @UsuarioID INT
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @TieneClaves BIT;
    
    SELECT @TieneClaves = CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END
    FROM ClavesDigitales 
    WHERE UsuarioID = @UsuarioID AND Activa = 1;
    
    SELECT @TieneClaves AS TieneClaves;
END;
GO


DROP PROCEDURE [dbo].[GenerarFactura]


CREATE PROCEDURE [dbo].[GenerarFactura]
    @CedulaCliente NVARCHAR(20),
    @IDMascota INT = NULL,
    @UsuarioFirma INT,
    @FirmaDigital NVARCHAR(MAX) = NULL  -- CAMBIO: Era VARBINARY(MAX), ahora es NVARCHAR(MAX)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        -- Validar existencia del cliente
        IF NOT EXISTS (SELECT 1 FROM Cliente WHERE Cedula = @CedulaCliente)
        BEGIN
            RAISERROR ('El cliente no existe.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        -- Validar que el usuario existe y est� activo
        IF NOT EXISTS (SELECT 1 FROM Usuarios WHERE UsuarioID = @UsuarioFirma AND Activo = 1)
        BEGIN
            RAISERROR ('Usuario no v�lido para firmar factura.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        -- Insertar la factura CON LA FIRMA DIGITAL (ahora como NVARCHAR)
        INSERT INTO Factura (IDMascota, CedulaCliente, Fecha, UsuarioFirma, FechaFirma, FirmaDigital)
        VALUES (@IDMascota, @CedulaCliente, GETDATE(), @UsuarioFirma, GETDATE(), @FirmaDigital);

        -- Obtener el ID de la factura reci�n insertada
        DECLARE @IDFactura INT = SCOPE_IDENTITY();

        -- Confirmar transacci�n
        COMMIT TRANSACTION;
        
        -- Devolver el ID de la factura
        SELECT @IDFactura AS IDFactura;
        
    END TRY
    BEGIN CATCH
        -- Manejo de errores
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;
GO



---------------------------------------------------------------------------------------------------

-- 2. Procedimiento para buscar facturas por diferentes criterios
CREATE OR ALTER   PROCEDURE [dbo].[BuscarFacturas]
    @Termino NVARCHAR(100) = '',
    @TipoBusqueda NVARCHAR(20) = 'TODOS', -- 'ID', 'CLIENTE', 'MASCOTA', 'USUARIO', 'TODOS'
    @FechaInicio DATE = NULL,
    @FechaFin DATE = NULL,
    @EstadoFactura NVARCHAR(20) = 'TODOS' -- 'Completada', 'Pendiente', 'TODOS'
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @SQL NVARCHAR(MAX);
    DECLARE @WHERE NVARCHAR(MAX) = ' WHERE 1=1 ';
    
    -- Construir filtros din�micamente
    IF @FechaInicio IS NOT NULL
        SET @WHERE = @WHERE + ' AND f.Fecha >= @FechaInicio ';
        
    IF @FechaFin IS NOT NULL
        SET @WHERE = @WHERE + ' AND f.Fecha <= DATEADD(DAY, 1, @FechaFin) ';
    
    IF @EstadoFactura != 'TODOS'
    BEGIN
        IF @EstadoFactura = 'Completada'
            SET @WHERE = @WHERE + ' AND f.totalFactura IS NOT NULL ';
        ELSE IF @EstadoFactura = 'Pendiente'
            SET @WHERE = @WHERE + ' AND f.totalFactura IS NULL ';
    END
    
    -- Filtros de b�squeda por t�rmino
    IF @Termino != '' AND @Termino IS NOT NULL
    BEGIN
        IF @TipoBusqueda = 'ID'
            SET @WHERE = @WHERE + ' AND CAST(f.IDFactura AS NVARCHAR) LIKE ''%' + @Termino + '%'' ';
        ELSE IF @TipoBusqueda = 'CLIENTE'
            SET @WHERE = @WHERE + ' AND (c.Nombre LIKE ''%' + @Termino + '%'' OR c.Cedula LIKE ''%' + @Termino + '%'') ';
        ELSE IF @TipoBusqueda = 'MASCOTA'
            SET @WHERE = @WHERE + ' AND m.Nombre LIKE ''%' + @Termino + '%'' ';
        ELSE IF @TipoBusqueda = 'USUARIO'
            SET @WHERE = @WHERE + ' AND (u.NombreCompleto LIKE ''%' + @Termino + '%'' OR u.NombreUsuario LIKE ''%' + @Termino + '%'') ';
        ELSE -- TODOS
            SET @WHERE = @WHERE + ' AND (
                CAST(f.IDFactura AS NVARCHAR) LIKE ''%' + @Termino + '%''
                OR c.Nombre LIKE ''%' + @Termino + '%''
                OR c.Cedula LIKE ''%' + @Termino + '%''
                OR m.Nombre LIKE ''%' + @Termino + '%''
                OR u.NombreCompleto LIKE ''%' + @Termino + '%''
                OR u.NombreUsuario LIKE ''%' + @Termino + '%''
            ) ';
    END
    
    SET @SQL = '
    SELECT 
        f.IDFactura,
        f.CedulaCliente,
        c.Nombre AS NombreCliente,
        f.IDMascota,
        m.Nombre AS NombreMascota,
        f.Fecha AS FechaFactura,
        f.subtotalf AS Subtotal,
        f.ITBMSFactura AS ITBMS,
        f.totalFactura AS Total,
        f.UsuarioFirma,
        u.NombreCompleto AS NombreFirmante,
        u.NombreUsuario AS UsuarioFirmante,
        r.NombreRol AS RolFirmante,
        f.FechaFirma,
        CASE WHEN f.FirmaDigital IS NOT NULL THEN 1 ELSE 0 END AS TieneFirmaDigital,
        CASE 
            WHEN f.totalFactura IS NOT NULL THEN ''Completada''
            ELSE ''Pendiente''
        END AS EstadoFactura,
        ISNULL(item_count.TotalItems, 0) AS TotalItems
    FROM Factura f
    INNER JOIN Cliente c ON f.CedulaCliente = c.Cedula
    LEFT JOIN Mascota m ON f.IDMascota = m.IDMascota
    INNER JOIN Usuarios u ON f.UsuarioFirma = u.UsuarioID
    INNER JOIN Roles r ON u.RolID = r.RolID
    LEFT JOIN (
        SELECT IDFactura, COUNT(*) AS TotalItems
        FROM Venta
        GROUP BY IDFactura
    ) item_count ON f.IDFactura = item_count.IDFactura'
    + @WHERE + '
    ORDER BY f.Fecha DESC, f.IDFactura DESC;';
    
    -- Ejecutar consulta din�mica
    EXEC sp_executesql @SQL, 
        N'@FechaInicio DATE, @FechaFin DATE', 
        @FechaInicio, @FechaFin;
END;
GO

---------------------------------------------

USE [CliniPet]
GO

/****** Object:  StoredProcedure [dbo].[CompletarFactura]    Script Date: 28/7/2025 12:17:47 ******/
DROP PROCEDURE [dbo].[CompletarFactura]
GO

/****** Object:  StoredProcedure [dbo].[CompletarFactura]    Script Date: 28/7/2025 12:17:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[CompletarFactura]
    @IDFactura INT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        -- Calcular el subtotal sumando todas las l�neas de la factura
        DECLARE @Subtotal DECIMAL(10, 2);
        SELECT @Subtotal = SUM(PrecioBruto)
        FROM Venta
        WHERE IDFactura = @IDFactura;

        -- Calcular el ITBMS (7% del subtotal)
        DECLARE @ITBMS DECIMAL(10, 2) = @Subtotal * 0.07;

        -- Calcular el total (subtotal + ITBMS)
        DECLARE @Total DECIMAL(10, 2) = @Subtotal + @ITBMS;

        -- Actualizar los campos de la factura
        UPDATE Factura
        SET 
            subtotalf = @Subtotal,
            ITBMSFactura = @ITBMS,
            totalFactura = @Total
        WHERE IDFactura = @IDFactura;

        COMMIT TRANSACTION;

        PRINT 'Factura completada correctamente.';
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;
GO

---------------------------------------
USE [CliniPet]
GO

/****** Object:  StoredProcedure [dbo].[GuardarClavesUsuario]    Script Date: 28/7/2025 12:18:48 ******/
DROP PROCEDURE [dbo].[GuardarClavesUsuario]
GO

/****** Object:  StoredProcedure [dbo].[GuardarClavesUsuario]    Script Date: 28/7/2025 12:18:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[GuardarClavesUsuario]
    @UsuarioID INT,
    @ClavePublica TEXT,
    @ClavePrivadaCifrada TEXT,
    @PasswordHash NVARCHAR(255),
    @Fingerprint NVARCHAR(32)
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Desactivar claves anteriores
        UPDATE ClavesDigitales 
        SET Activa = 0 
        WHERE UsuarioID = @UsuarioID;
        
        -- Insertar nuevas claves
        INSERT INTO ClavesDigitales (UsuarioID, ClavePublica, ClavePrivadaCifrada, PasswordHash, Fingerprint, Activa)
        VALUES (@UsuarioID, @ClavePublica, @ClavePrivadaCifrada, @PasswordHash, @Fingerprint, 1);
        
        COMMIT TRANSACTION;
        
        -- IMPORTANTE: Retornar resultado expl�cito
        SELECT 1 AS Exito, 'Claves guardadas exitosamente' AS Mensaje;
        
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        
        -- Retornar error expl�cito
        SELECT 0 AS Exito, ERROR_MESSAGE() AS Mensaje;
    END CATCH
END;
GO


--------------------------------
USE [CliniPet]
GO

/****** Object:  StoredProcedure [dbo].[ObtenerClavesUsuario]    Script Date: 28/7/2025 12:19:23 ******/
DROP PROCEDURE [dbo].[ObtenerClavesUsuario]
GO

/****** Object:  StoredProcedure [dbo].[ObtenerClavesUsuario]    Script Date: 28/7/2025 12:19:23 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ObtenerClavesUsuario]
    @UsuarioID INT
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        ClavePublica,
        ClavePrivadaCifrada,
        PasswordHash,
        Fingerprint,
        FechaGeneracion
    FROM ClavesDigitales 
    WHERE UsuarioID = @UsuarioID AND Activa = 1;
END;
GO

---------------------------------------------------
USE [CliniPet]
GO

/****** Object:  StoredProcedure [dbo].[ObtenerDetallesFacturaCompletos]    Script Date: 28/7/2025 12:19:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- 4. Procedimiento para obtener detalles completos de una factura (mejorado)
CREATE OR ALTER   PROCEDURE [dbo].[ObtenerDetallesFacturaCompletos]
    @IDFactura INT
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Informaci�n principal de la factura
    SELECT 
        f.IDFactura,
        f.CedulaCliente,
        c.Nombre AS NombreCliente,
        c.Tel�fono AS TelefonoCliente,
        c.Email AS EmailCliente,
        c.Direcci�n AS DireccionCliente,
        f.IDMascota,
        m.Nombre AS NombreMascota,
        m.Especie,
        m.Peso,
        m.Edad,
        m.Genero,
        r.Nombre AS RazaMascota,
        f.Fecha AS FechaFactura,
        f.subtotalf AS Subtotal,
        f.ITBMSFactura AS ITBMS,
        f.totalFactura AS Total,
        -- INFORMACI�N DE LA FIRMA
        f.UsuarioFirma,
        u.NombreCompleto AS NombreFirmante,
        u.NombreUsuario AS UsuarioFirmante,
        u.Email AS EmailFirmante,
        rol.NombreRol AS RolFirmante,
        f.FechaFirma,
        f.FirmaDigital,
        CASE WHEN f.FirmaDigital IS NOT NULL THEN 1 ELSE 0 END AS TieneFirmaDigital,
        CASE 
            WHEN f.totalFactura IS NOT NULL THEN 'Completada'
            ELSE 'Pendiente'
        END AS EstadoFactura
    FROM Factura f
    INNER JOIN Cliente c ON f.CedulaCliente = c.Cedula
    LEFT JOIN Mascota m ON f.IDMascota = m.IDMascota
    LEFT JOIN Raza r ON m.RazaID = r.RazaID
    INNER JOIN Usuarios u ON f.UsuarioFirma = u.UsuarioID
    INNER JOIN Roles rol ON u.RolID = rol.RolID
    WHERE f.IDFactura = @IDFactura;
    
    -- Items de la factura
    SELECT 
        v.IDVenta,
        v.IDITEM,
        sp.NombreProducto,
        sp.Tipo,
        v.CantidadVendida,
        v.PrecioBruto,
        v.ITBMSLinea,
        v.totalLinea,
        (v.PrecioBruto / v.CantidadVendida) AS PrecioUnitario
    FROM Venta v
    INNER JOIN Servicio_Producto sp ON v.IDITEM = sp.IDITEM
    WHERE v.IDFactura = @IDFactura
    ORDER BY sp.Tipo, sp.NombreProducto;
END;
GO

------------------------------------------------
USE [CliniPet]
GO

/****** Object:  StoredProcedure [dbo].[ObtenerFacturaConFirma]    Script Date: 28/7/2025 12:20:38 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [dbo].[ObtenerFacturaConFirma]
    @IDFactura INT
AS
BEGIN
    SELECT 
        f.IDFactura,
        f.CedulaCliente,
        c.Nombre AS NombreCliente,
        f.IDMascota,
        m.Nombre AS NombreMascota,
        f.Fecha AS FechaFactura,
        f.subtotalf,
        f.ITBMSFactura,
        f.totalFactura,
        -- INFORMACI�N DE LA FIRMA
        f.UsuarioFirma,
        u.NombreCompleto AS NombreFirmante,
        u.NombreUsuario AS UsuarioFirmante,
        r.NombreRol AS RolFirmante,
        f.FechaFirma,
        f.FirmaDigital,
        -- Determinar si tiene firma v�lida (se verificar� en PHP)
        CASE WHEN f.FirmaDigital IS NOT NULL THEN 1 ELSE 0 END AS TieneFirmaDigital
    FROM Factura f
    INNER JOIN Cliente c ON f.CedulaCliente = c.Cedula
    LEFT JOIN Mascota m ON f.IDMascota = m.IDMascota
    INNER JOIN Usuarios u ON f.UsuarioFirma = u.UsuarioID
    INNER JOIN Roles r ON u.RolID = r.RolID
    WHERE f.IDFactura = @IDFactura;
END;
GO

-------------------------------------------------------------
USE [CliniPet]
GO

/****** Object:  StoredProcedure [dbo].[ObtenerFacturasPorUsuario]    Script Date: 28/7/2025 12:21:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- 5. Procedimiento para obtener facturas por usuario espec�fico
CREATE OR ALTER   PROCEDURE [dbo].[ObtenerFacturasPorUsuario]
    @UsuarioID INT,
    @Limit INT = 20
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        f.IDFactura,
        f.CedulaCliente,
        c.Nombre AS NombreCliente,
        f.IDMascota,
        m.Nombre AS NombreMascota,
        f.Fecha AS FechaFactura,
        f.totalFactura AS Total,
        CASE 
            WHEN f.totalFactura IS NOT NULL THEN 'Completada'
            ELSE 'Pendiente'
        END AS EstadoFactura,
        CASE WHEN f.FirmaDigital IS NOT NULL THEN 1 ELSE 0 END AS TieneFirmaDigital
    FROM Factura f
    INNER JOIN Cliente c ON f.CedulaCliente = c.Cedula
    LEFT JOIN Mascota m ON f.IDMascota = m.IDMascota
    WHERE f.UsuarioFirma = @UsuarioID
    ORDER BY f.Fecha DESC, f.IDFactura DESC
    OFFSET 0 ROWS
    FETCH NEXT @Limit ROWS ONLY;
END;
GO


----------------------------------------
USE [CliniPet]
GO

/****** Object:  StoredProcedure [dbo].[ObtenerHistorialFacturas]    Script Date: 28/7/2025 12:21:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- 1. Procedimiento para obtener historial completo de facturas
CREATE OR ALTER   PROCEDURE [dbo].[ObtenerHistorialFacturas]
    @UsuarioID INT = NULL,  -- Para filtrar por usuario (opcional)
    @FechaInicio DATE = NULL,
    @FechaFin DATE = NULL,
    @Limit INT = 50,
    @Offset INT = 0
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Si no se especifican fechas, usar �ltimos 30 d�as
    IF @FechaInicio IS NULL
        SET @FechaInicio = DATEADD(DAY, -30, GETDATE());
    
    IF @FechaFin IS NULL
        SET @FechaFin = GETDATE();
    
    SELECT 
        f.IDFactura,
        f.CedulaCliente,
        c.Nombre AS NombreCliente,
        f.IDMascota,
        m.Nombre AS NombreMascota,
        f.Fecha AS FechaFactura,
        f.subtotalf AS Subtotal,
        f.ITBMSFactura AS ITBMS,
        f.totalFactura AS Total,
        -- INFORMACI�N DE LA FIRMA
        f.UsuarioFirma,
        u.NombreCompleto AS NombreFirmante,
        u.NombreUsuario AS UsuarioFirmante,
        r.NombreRol AS RolFirmante,
        f.FechaFirma,
        CASE WHEN f.FirmaDigital IS NOT NULL THEN 1 ELSE 0 END AS TieneFirmaDigital,
        -- Estado de la factura
        CASE 
            WHEN f.totalFactura IS NOT NULL THEN 'Completada'
            ELSE 'Pendiente'
        END AS EstadoFactura,
        -- Conteo de items
        ISNULL(item_count.TotalItems, 0) AS TotalItems
    FROM Factura f
    INNER JOIN Cliente c ON f.CedulaCliente = c.Cedula
    LEFT JOIN Mascota m ON f.IDMascota = m.IDMascota
    INNER JOIN Usuarios u ON f.UsuarioFirma = u.UsuarioID
    INNER JOIN Roles r ON u.RolID = r.RolID
    LEFT JOIN (
        SELECT IDFactura, COUNT(*) AS TotalItems
        FROM Venta
        GROUP BY IDFactura
    ) item_count ON f.IDFactura = item_count.IDFactura
    WHERE 
        f.Fecha >= @FechaInicio 
        AND f.Fecha <= DATEADD(DAY, 1, @FechaFin)
        AND (@UsuarioID IS NULL OR f.UsuarioFirma = @UsuarioID)
    ORDER BY f.Fecha DESC, f.IDFactura DESC
    OFFSET @Offset ROWS
    FETCH NEXT @Limit ROWS ONLY;
END;
GO

-----------------------------------------
USE [CliniPet]
GO

/****** Object:  StoredProcedure [dbo].[VerificarAccesoFactura]    Script Date: 28/7/2025 12:23:06 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- 6. Procedimiento para verificar permisos de acceso a facturas
CREATE OR ALTER   PROCEDURE [dbo].[VerificarAccesoFactura]
    @IDFactura INT,
    @UsuarioID INT
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @RolUsuario INT;
    DECLARE @UsuarioFirma INT;
    DECLARE @TieneAcceso BIT = 0;
    
    -- Obtener rol del usuario
    SELECT @RolUsuario = RolID FROM Usuarios WHERE UsuarioID = @UsuarioID;
    
    -- Obtener quien firm� la factura
    SELECT @UsuarioFirma = UsuarioFirma FROM Factura WHERE IDFactura = @IDFactura;
    
    -- Verificar acceso
    IF @RolUsuario = 1 -- Administrador
        SET @TieneAcceso = 1;
    ELSE IF @RolUsuario = 2 -- Operador
        SET @TieneAcceso = 1;
    ELSE IF @RolUsuario = 3 AND @UsuarioFirma = @UsuarioID -- Cliente, solo sus facturas
        SET @TieneAcceso = 1;
    
    SELECT @TieneAcceso AS TieneAcceso;
END;
GO



-----------------------

SELECT * FROM Cliente





------------------------------------------------------------------------------------------
-- Tabla de citas para CliniPet
CREATE TABLE Cita (
    IDCita INT IDENTITY(1,1) PRIMARY KEY,
    CedulaCliente VARCHAR(20) NOT NULL,
    IDMascota INT NOT NULL,
    IDITEM INT NOT NULL, -- Servicio
    Fecha DATE NOT NULL,
    Hora VARCHAR(10) NOT NULL,
    Observaciones VARCHAR(255),
    Estado VARCHAR(20) NOT NULL DEFAULT 'pendiente', -- pendiente, cancelada, completada
    FechaCreacion DATETIME DEFAULT GETDATE()
);

-- Procedimiento para registrar cita
CREATE PROCEDURE RegistrarCita
    @CedulaCliente VARCHAR(20),
    @IDMascota INT,
    @IDITEM INT,
    @Fecha DATE,
    @Hora VARCHAR(10),
    @Observaciones VARCHAR(255)
AS
BEGIN
    INSERT INTO Cita (CedulaCliente, IDMascota, IDITEM, Fecha, Hora, Observaciones, Estado)
    VALUES (@CedulaCliente, @IDMascota, @IDITEM, @Fecha, @Hora, @Observaciones, 'pendiente');
    SELECT SCOPE_IDENTITY() AS IDCita;
END

-- Procedimiento para modificar cita
CREATE PROCEDURE ModificarCita
    @IDCita INT,
    @IDITEM INT,
    @Fecha DATE,
    @Hora VARCHAR(10),
    @Observaciones VARCHAR(255)
AS
BEGIN
    UPDATE Cita
    SET IDITEM = @IDITEM,
        Fecha = @Fecha,
        Hora = @Hora,
        Observaciones = @Observaciones
    WHERE IDCita = @IDCita;
END

-- Procedimiento para cancelar cita
CREATE PROCEDURE CancelarCita
    @IDCita INT
AS
BEGIN
    UPDATE Cita
    SET Estado = 'cancelada'
    WHERE IDCita = @IDCita;
END

-- Procedimiento para listar citas por cliente
CREATE PROCEDURE ListarCitasPorCliente
    @CedulaCliente VARCHAR(20)
AS
BEGIN
    SELECT * FROM Cita WHERE CedulaCliente = @CedulaCliente ORDER BY Fecha DESC, Hora DESC;
END

-- Procedimiento para listar citas pendientes
CREATE PROCEDURE ListarCitasPendientes
AS
BEGIN
    SELECT * FROM Cita WHERE Estado = 'pendiente' ORDER BY Fecha, Hora;
END



-----------------------------------------------------------------------------------------------------------