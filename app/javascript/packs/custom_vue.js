import Vue from 'vue/dist/vue.esm'
import App from '../app.vue'

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '#test',
    data: {
      message: "これで任意の場所に表示させたいどうなんだ。"
    },
    components: { App }
  })
})