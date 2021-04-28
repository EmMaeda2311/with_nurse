import Vue from 'vue'
import router from "./router"
import App from '../app.vue'

document.addEventListener('turbolinks:load', () => {
  new Vue({
    router,
    render: h => h(App)
  }).$mount("#app")
})