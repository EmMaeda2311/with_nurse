<template>
  <div id="app">
     <div class="container">
      <nav class="flex game-nav">
        <router-link to="/typing"
                    tag="div"
                    class="game-menu menu-typing">
                    <img src="../assets/images/typing.png" alt="タイピングゲーム" width= 100px>
                    </router-link>

        <router-link to="/word-quiz"
                    tag="div"
                    class="game-menu menu-three-quiz">
                    <img src="../assets/images/three-quiz.png" alt="略語クイズ" width= 100px>
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