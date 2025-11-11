# 🔐 Sistema de Login - Vue 3 + Vite

Aplicación web de login desarrollada con Vue 3 y Vite, utilizando Ant Design Vue para los componentes de interfaz de usuario.

## 🚀 Características

- ✨ Interfaz de login moderna y responsiva
- 🎨 Diseño con Ant Design Vue
- 📱 Completamente responsive
- 🔒 Campos de email y contraseña con validación
- ⚡ Hot Module Replacement (HMR) con Vite
- 🌐 Configuración para despliegue en AWS Amplify

## 🛠️ Tecnologías Utilizadas

- **Vue 3** - Framework JavaScript progresivo
- **Vite** - Build tool de nueva generación
- **Ant Design Vue** - Biblioteca de componentes UI
- **Ant Design Icons Vue** - Iconos para la interfaz
- **Terraform** - Infraestructura como código (IaC)
- **AWS S3** - Hosting estático con Terraform
- **AWS Amplify** - Plataforma de despliegue continuo

## 📋 Requisitos Previos

- Node.js (versión 16 o superior)
- pnpm (recomendado) o npm
- Cuenta de AWS (para despliegue con Terraform)

## ⚙️ Instalación

1. Clonar el repositorio:
```bash
git clone <url-del-repositorio>
cd login
```

2. Instalar dependencias:
```bash
pnpm install
# o
npm install
```

## 🚀 Uso

### Modo Desarrollo

Ejecutar el servidor de desarrollo con hot-reload:
```bash
pnpm dev
# o
npm run dev
```

La aplicación estará disponible en `http://localhost:5173`

### Build para Producción

Compilar y minificar para producción:
```bash
pnpm build
# o
npm run build
```

### Vista Previa del Build

Previsualizar el build de producción localmente:
```bash
pnpm preview
# o
npm run preview
```

## 📁 Estructura del Proyecto

```
login/
├── src/
│   ├── components/
│   │   └── Login.vue          # Componente principal de login
│   ├── assets/                # Recursos estáticos
│   ├── App.vue                # Componente raíz
│   ├── main.js                # Punto de entrada
│   └── style.css              # Estilos globales
├── terraform/
│   └── main.tf                # Configuración de infraestructura AWS
├── public/                    # Archivos públicos estáticos
├── amplify.yml                # Configuración de AWS Amplify
├── vite.config.js             # Configuración de Vite
└── package.json               # Dependencias del proyecto
```

## 🌐 Despliegue

### AWS Amplify

El proyecto está configurado para desplegarse automáticamente en AWS Amplify. La configuración se encuentra en `amplify.yml`:

- Usa pnpm para gestión de paquetes
- Build automático con Vite
- Artifacts en la carpeta `dist/`

### Terraform (AWS S3)

Para desplegar la infraestructura en AWS con Terraform:

1. Navegar a la carpeta terraform:
```bash
cd terraform
```

2. Inicializar Terraform:
```bash
terraform init
```

3. Aplicar la configuración:
```bash
terraform apply -var="main_bucket=nombre-de-tu-bucket"
```

Esto creará:
- Bucket S3 con hosting estático
- Políticas públicas para acceso web
- Configuración de website en S3

## 🎨 Componentes

### Login.vue

Componente principal que incluye:
- Campo de correo electrónico con icono
- Campo de contraseña con opción de visualización
- Botón de inicio de sesión
- Diseño centrado con imagen de fondo
- Formulario con validación de Ant Design

## 📚 Recursos

- [Documentación de Vue 3](https://v3.vuejs.org/)
- [Documentación de Vite](https://vitejs.dev/)
- [Documentación de Ant Design Vue](https://antdv.com/)
- [Script Setup en Vue 3](https://v3.vuejs.org/api/sfc-script-setup.html)
- [Guía de Escalado de Vue](https://vuejs.org/guide/scaling-up/tooling.html#ide-support)

## 📝 Licencia

Este proyecto es privado y de uso educativo.

---

Desarrollado con ❤️ usando Vue 3 y Vite
