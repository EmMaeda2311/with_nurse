<template>
  <div>
   
    <div class="el-modal" :aria-hidden="isOpen ? 'false' : 'true'">
      <div class="el-modal__holder">
        <button @click="close()"><font-awesome-icon :icon= "['fas', 'times']" /></button>
        <div class="change-avatar">サムネイルを変更する</div>
        <div class="delete-avatar">初期に戻す</div>
      </div>
      <div @click="close()" class="el-modal__overlay"></div>
    </div>
    <div @click="open()"><font-awesome-icon :icon= "['fas', 'portrait']" /></div>
  </div>
</template>

<script>
export default {
  name: "Modal",
  data: function() {
    return {
      isOpen: false
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
