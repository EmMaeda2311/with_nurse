/* eslint no-console: 0 */
// Run this example by adding <%= javascript_pack_tag 'hello_vue' %> (and
// <%= stylesheet_pack_tag 'hello_vue' %> if you have styles in your component)
// to the head of your layout file,
// like app/views/layouts/application.html.erb.
// All it does is render <div>Hello Vue</div> at the bottom of the page.

import Vue from 'vue'
// import Vue from "vue/dist/vue/vue.esm.js";
import LikeButton from '../components/Like/LikeButton.vue'
import GuestTyping from '../components/Game/GuestTyping.vue'
// import Modal from '../components/Modal/Modal.vue'

import { library } from '@fortawesome/fontawesome-svg-core'
import { fas } from '@fortawesome/free-solid-svg-icons'
import { FontAwesomeIcon } from '@fortawesome/vue-fontawesome'
import router from "./router"
import App from '../app.vue'
library.add(fas)

Vue.component('font-awesome-icon', FontAwesomeIcon)


document.addEventListener('turbolinks:load', () => {
  new Vue({
    router,
    render: h => h(App)
  }).$mount("#app")
})




document.addEventListener('turbolinks:load', () => {
  new Vue({
    el: '#guest_game',
    components: { GuestTyping }
    // render: h => h( LikeButton ,{ props: document.getElementById('like-list').dataset })
  })
})

document.addEventListener('turbolinks:load', () => {
  new Vue({
    el: '#like',
    components: { LikeButton }
    // render: h => h( LikeButton ,{ props: document.getElementById('like-list').dataset })
  })
})

document.addEventListener('DOMContentLoaded', () => {
  new Vue({
    el: '#modal',
    components: { Modal }
    // render: h => h( LikeButton ,{ props: document.getElementById('like-list').dataset })
  })
  console.log("test")
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
      // アップロードした画像を表示
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