<template>
  <div id="app">
     <div class="container">
      <nav class="flex game-nav">
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

      
    
        <router-view></router-view>

      <hr>
      <div class="home">
        <router-link to="/"
          tag="div"
          class="btn btn-blue btn-lg">
          GAME HOMEに戻る
        </router-link>
      </div>

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