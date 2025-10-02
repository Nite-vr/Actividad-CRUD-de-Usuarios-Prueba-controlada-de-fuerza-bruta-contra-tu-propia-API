#Proyecto de API FastAPI con Sistema de Autenticación
Este proyecto es una API RESTful construida con FastAPI que implementa un sistema básico de gestión de usuarios y autenticación. Diseñado para fines educativos y de aprendizaje sobre desarrollo de APIs y seguridad.

Características
- FastAPI: Framework moderno y rápido para APIs con Python
- SQLModel: Para modelos de datos y base de datos
- Sistema de Usuarios: CRUD completo de usuarios
- Autenticación: Endpoint de login con validación
- Documentación Automática: Interfaz Swagger UI integrada
- Base de Datos en Memoria: Almacenamiento temporal para desarrollo
- GitBash para hacer el ataque a la propia API

Endpoints Disponibles
- POST /usuarios - Crear nuevo usuario
- GET /listUsers - Listar todos los usuarios
- GET /userID/{id} - Obtener usuario por ID
- PUT /insertUser/{id} - Actualizar usuario
- DELETE /deleteUser/{id} - Eliminar usuario

Instalación y Configuración
Prerrequisitos
- Python 3.8+
- pip (gestor de paquetes de Python)

Para copiar:
DESDE CMD
- cd 
- mkdir code / cd code
- mkdir... / cd awesome-project
- Crear entorno virtual
- python -m venv .env
- awesome-project>.env\Scripts\Activate
- python -m pip install --upgrade pip
- python -m pip install fastapi uvicorn sqlalchemy passlib[bcrypt] pydantic requests
- code .

DESDE VSCODE
crear main.py (copiar codigo)
Terminal VsCode: 
- pip install "fastapi[standard]"
- pip install sqlmodel
Activar el entorno Virtual:
uvicorn main:app --reload --port 8000

Probar en 
 http://127.0.0.1:8000
 http://127.0.0.1:8000/docs

DESDE GITBASH
cd awesome-project
1. Verificar que la API esta corriendo:
    curl -X POST http://127.0.0.1:8000/login \
     -H "Content-Type: application/json" \
     -d '{"email":"nicolas@gmail.com","password":"Uide"}'

2. Crear el script de Fuerza Bruta
Desde GitBash: pegar el script adjuntado "GitBash.txt"
Desde VsCode: crear el archivo bruteforce.sh y copiar el script sin el comando inicial.
3. Dar permisos chmod +x bruteforce.sh
4. Prueba:
./bruteforce.sh http://127.0.0.1:8000/login lily@gmail.com 2
./bruteforce.sh http://127.0.0.1:8000/login nicolas@gmail.com 4
(el numero cambia debe coincidir con la contraseña de la api en este caso)
  # Ver el log en tiempo real
tail -f attack_log.txt  


Ejemplos de Uso
Crear Usuario
bash
curl -X POST "http://127.0.0.1:8000/usuarios" \
-H "Content-Type: application/json" \
-d '{"username": "nuevo_usuario", "password": "mi_contraseña", "email": "usuario@ejemplo.com"}'
Login
bash
curl -X POST "http://127.0.0.1:8000/login" \
-H "Content-Type: application/json" \
-d '{"email": "nicolas@gmail.com", "password": "Uide.edu.ec"}'

Estructura del Proyecto
text
awesome-project/
├── main.py          # Archivo principal de la aplicación
├── requirements.txt # Dependencias del proyecto
├── README.md       # Este archivo
└── venv/           # Entorno virtual (no se sube al repo)



Autor
Nicolas - nicolas@gmail.com


ADVERTENCIA: Este proyecto es exclusivamente para fines educativos y de aprendizaje. No usar en entornos de producción sin las debidas medidas de seguridad.

