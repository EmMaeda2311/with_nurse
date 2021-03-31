<template>
  <div id="app">
    <nav class="flex game-nav">
      <router-link to="/"
                   tag="div"
                   class="game-menu">
                   HOME
                   </router-link>

      <router-link to="/typing"
                   tag="div"
                   class="game-menu">
                   TYPING
                   </router-link>

      <router-link to="/word-quiz"
                   tag="div"
                   class="game-menu">
                   三択クイズ
                   </router-link>
    </nav>
    <div class="container">
      <router-view></router-view>
    </div>
  </div>
</template>

<style scoped>
  .game-nav{
    justify-content: space-around;
    margin-bottom: 100px;
  }


  .game-menu{
    text-align: center;
    padding: 30px;
    border-radius: 5px;
    background-color: #efebe0;
    cursor: pointer;
  }
</style>