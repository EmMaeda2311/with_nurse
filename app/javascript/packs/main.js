import Vue from 'vue'
// import Vue from "vue/dist/vue/vue.esm.js";
import LikeButton from '../components/Like/LikeButton.vue'
import GuestTyping from '../components/Game/GuestTyping.vue'
import App from '../app.vue'
import router from "./router"
// import Modal from '../components/Modal/Modal.vue'

import { library } from '@fortawesome/fontawesome-svg-core'
import { fas } from '@fortawesome/free-solid-svg-icons'
import { FontAwesomeIcon } from '@fortawesome/vue-fontawesome'
library.add(fas)

Vue.component('font-awesome-icon', FontAwesomeIcon)


document.addEventListener('turbolinks:load', () => {
  new Vue({
    router,
    render: h => h(App, {props: $('#app').data() })
  }).$mount("#app")
})

document.addEventListener('turbolinks:load', () => {
  new Vue({
    el: '#guest_game',
    components: { GuestTyping }
  })
})

document.addEventListener('turbolinks:load', () => {
  new Vue({
    el: '#like',
    components: { LikeButton }
  })
})


document.addEventListener('turbolinks:load', () => {
  new Vue({
    el: '#preview',
    data() {
      return {
        uploadedImage: '',
      };
    },
    methods: {
      onFileChange(e) {
        let files = e.target.files || e.dataTransfer.files;
        this.createImage(files[0]);
      },

      createImage(file) {
        let reader = new FileReader();
        reader.onload = (e) => {
          this.uploadedImage = e.target.result;
        };
        reader.readAsDataURL(file);
      },
    },
  })
})