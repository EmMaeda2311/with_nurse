<template>
  <div class="my-photo">
    <div v-if="uploadedImage == '' ">
      <div v-if="image == nil ">
        <img src="../../../images/nurse.png" alt="">
      </div>
      <div v-else>
        <img 
        v-show="image"
        :src="image" 
        alt="">
      </div>
    </div>
    <div v-else>
      <img
        v-show="uploadedImage"
        class="preview-item-file"
        :src="uploadedImage"
        alt=""
      />
    </div>


    <div class="el-modal" :aria-hidden="isOpen ? 'false' : 'true'">

      <div class="el-modal__holder">
        <div class="x-icon" @click="close()"><font-awesome-icon :icon= "['fas', 'times']" /></div>
        
        <label for="user-avatar" class="change-avatar">サムネイルを変更する
        <input @change="onFileChange" id="user-avatar" type="file" accept="image/png, image/jpeg" style= "display: none;">
        </label>
        
        <div class="delete-avatar">初期に戻す</div>
      </div>

      <div @click="close()" class="el-modal__overlay"></div>
    </div>
    
    <div @click="open()" class="portrait"><font-awesome-icon :icon= "['fas', 'portrait']" />
    </div>
  </div>

</template>

<script>
import axios from 'axios'
import { csrfToken } from 'rails-ujs'
// CSRFトークンの取得とリクエストヘッダへの設定をしてくれます
axios.defaults.headers.common['X-CSRF-TOKEN'] = csrfToken()

export default {
  props:'userAvatar',
  name: "Modal",
  data: function() {
    return {
      image = this.userAvatar,
      isOpen: false,
      uploadedImage: '',
    };
  },
  methods: {
    open: function() {
      this.isOpen = true;
    },
    close: function() {
      this.isOpen = false;
    },
    onFileChange(e) {
    const files = e.target.files || e.dataTransfer.files;
    this.createImage(files[0]);
    },

    createImage(file){
      const reader = new FileReader();
      reader.onload = e => {
        this.uploadedImage = e.target.result;  
      };
      reader.readAsDataURL(file);

    }
  }
};
</script>
