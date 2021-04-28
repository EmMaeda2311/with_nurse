<template>
  <div class="game-home">
    <h3>HOME</h3>

    <p>ナースのスキルを鍛えるゲームができます</p>
    <p>上のメニューよりゲームを選択して、あなたのスキルを伸ばしましょう</p>
  
    <div class="game-status">
      <div class="player-info">
        <div class="user-avatar">
          <img :src="user.avatar" alt="" v-if="avatarAtache">
          <img src="../../../assets/images/nurse.png" alt="" v-else>
        </div>
        <h4 class="player-name">{{user.username}}</h4>
      </div>
      <div class="player-score">
        <h4 class="nurse-typing">Nurse Typing</h4>

        <table>
          <tr>
            <th>タイピングの正確さ</th>
            <td>{{userScore.hi_score}} %</td>
          </tr>
          <tr>
            <th>タイピングスピード</th>
            <td>{{userScore.hi_speed}} 打鍵 / 分</td>
          </tr>
          <tr>
            <th>プレイ回数</th>
            <td>{{userScore.plays}} 回</td>
          </tr>
        </table>
      </div>
    </div>
    
  </div>

  
</template>

<script>
import axios from 'axios';

export default {
  data(){
    return{
      userScore:{},
      user:{},
      avatarAtache: true
    }
  },
  computed:{
    avatarPresent() {
      if(this.user.avatar != null){
        this.avatarAtache = true
      }
    }
  },
  created(){
    axios
      .get(`/api/user_typings/${this.typingUserId}.json`)
      .then(response => (this.userScore = response.data))
    axios
      .get(`/users/${this.typingUserId}/game.json`)
      .then(response => (this.user = response.data))    
  }
}
</script>
