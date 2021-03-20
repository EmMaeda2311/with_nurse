<template>
  <div class="my-photo">
    <img
      v-show="uploadedImage"
      class="preview-item-file"
      :src="uploadedImage"
      alt=""
    />

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
    
    <div @click="open()" class="portrait"><font-awesome-icon :icon= "['fas', 'portrait']" /></div>
  </div>

</template>

<script>
export default {
  name: "Modal",
  data: function() {
    return {
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
    }
  }
};
</script>
