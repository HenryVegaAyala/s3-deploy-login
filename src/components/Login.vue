<template>
  <div class="login-container">
    <a-form name="login" autocomplete="off" class="login-form" :model="form">
      <div>

        <div class="logo-container">
          <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTodTA_uzjXXbVJxfatvmWfGMZoDFJWX_Kl-g&s"
               alt="logo">
        </div>

        <a-form-item name="email">
          <a-input v-model:value="form.username" placeholder="Correo electrónico" allow-clear>
            <template #prefix>
              <user-outlined/>
            </template>
          </a-input>
        </a-form-item>

        <a-form-item name="password">
          <a-input-password v-model:value="form.password" placeholder="Contraseña" allow-clear>
            <template #prefix>
              <lock-outlined/>
            </template>
          </a-input-password>
        </a-form-item>

        <a-form-item>
          <a-button type="primary" class="button-primary">Iniciar sesión</a-button>
        </a-form-item>
      </div>
    </a-form>
  </div>
</template>

<script setup>
import {ref} from "vue";
import {UserOutlined, LockOutlined} from "@ant-design/icons-vue"

const form = ref({
  username: '',
  password: ''
});

</script>

<style scoped>
.login-container {
  background-image: url('https://t4.ftcdn.net/jpg/02/10/45/95/360_F_210459536_XmLDEcKq2DpeNLVmheuWeu9NM9aGKnih.jpg');
  background-size: cover;
  background-position: center;
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100vh;

  .login-form {
    max-width: 350px;
    width: 100%;
    padding: 20px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
    border-radius: 4px;
    background-color: white;
  }

  .button-primary {
    width: 100%;
  }

  .logo-container {
    margin-bottom: 1rem;
    text-align: center;

    img {
      width: 200px;
      height: auto;
    }
  }
}
</style>
