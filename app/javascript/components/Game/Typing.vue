<template>
<div id="typing-game">
  <h1>Nurse Typing</h1>
  <!-- ゲーム中の画面 -->
  <div v-if="trying">

    <div v-if="!isFinished">
      <p class="read" v-text="currentWord.read"></p>   
      <h3 v-text="currentWord.name"></h3>
      <p ref="target" class="spell" v-text="currentWord.spell"></p>
    </div>

    <div>
      <!-- ゲーム終了後のメッセージ -->
      <h3 v-if="isFinished" v-text="typingLank"></h3>
      <p v-text="finishMessage"></p>   
      <p v-if="!isFinished" v-text="nowTimerMessage"></p>

      <div v-if="isFinished">
        <button class="btn btn-blue btn-lg" @click="stopGame()">もう一度プレイする</button>
      </div>

    </div>
  </div>

  <!-- カウントダウン -->
  <div v-if="countDownStatus">
    <h3 v-text="countDownTime"></h3>
  </div>

  <!-- ゲーム開始前 -->
  <div v-if="!trying">
    <div class="user-score">
      <ul>
        <li>正確さ
          <span v-text="this.hiScoreText"></span>
        </li>
        <li>タイピングスピード
          <span v-text="this.hiSpeedText"></span>
        </li>
        <li>プレイ回数
          <span v-text="this.playsText"></span>
        </li>
      </ul>
    </div>
    <div class="btn btn-yellow btn-lg">Enterを押すと始まります</div>

    
  </div>
</div>
</template>

<script>
import axios from 'axios';
import { csrfToken } from 'rails-ujs'
axios.defaults.headers.common['X-CSRF-TOKEN'] = csrfToken()


export default {
  data(){
    return{
      trying: false,
      isFinished: false,
      countDownStatus: false,
      timeLimit: 120 * 1000,
      nowTimerMessage:"",
      startTime: 0,
      startCountTime: 3 * 1000,
      countDownTime: 0,
      loc: 0,
      goodType:0,
      missType:0,
      words: [],
      finishMessage: "",
      //回答済みの問題を入れる
      solvedWords: [],
      userScore:{
      },
      typingLank:""

    }
  },


  methods:{
    start() {
      this.trying = true;
      this.solvedWords = [];
      this.missType = 0
      
      this.startTime = Date.now();
      this.updateTimer();
    },

    CountDown(){
      this.countDownStatus = true
      this.startTime = Date.now();
      this.startCountDown()
    },

    stopGame(){
      this.trying = false
      this.isFinished = false
      this.finishMessage = ""
    },

    inputKey(e){
      //ゲームが終わっていたら、キーボード操作を無効
      if(this.isFinished == true){
        return;
      }
      // ゲームが始まっていない状態でEnterが押されたらゲームスタート
      if(this.trying == false && e.key == "Enter"){
        this.CountDown()
      }


      //もし入力した文字と現在の正しい文字が等しくなければmissTypeを＋して以降の処理を無視 
      if(e.key !== this.currentWord.spell[this.loc]){
        this.missType++;
        return;
      }

      //入力が正しければ何文字目を入力しているか＋ 
      this.loc++;
      this.goodType++;
      this.$refs.target.textContent = '_'.repeat(this.loc) + this.currentWord.spell.substring(this.loc)

      if( this.loc === this.currentWord.spell.length){
        this.solvedWords.push(this.currentWord)
        this.loc = 0

        if(this.words.length == this.solvedWords.length){
          this.finishMessage = `正答率${this.showResult}％ タイピングスピード${this.showTypeSpeed}打鍵 / 分`
          this.isFinished = true
          this.loc = 0
          this.typingLank = this.lank
             
        }
      } 
    },

    startCountDown(){
      const startTimeLeft = this.startTime + this.startCountTime - Date.now();
      const nowDownTime = (startTimeLeft / 1000).toFixed(0)
      this.countDownTime = nowDownTime
      const timeoutId = setTimeout(() => {
        this.startCountDown()
      },1000)

      if(this.countDownTime < 1){
        this.start()
        this.countDownStatus = false

        clearTimeout(timeoutId);
      }
      
    },
  
    updateTimer(){
      const timeLeft = this.startTime + this.timeLimit - Date.now();
      const nowTime = (timeLeft / 1000).toFixed(2)
      this.nowTimerMessage = nowTime
      const timeoutId = setTimeout(() => {
        this.updateTimer()
      },10)

      if(this.nowTimerMessage < 0){
        this.isFinished = true

        clearTimeout(timeoutId);
        this.nowTimerMessage = "0.00"
        setTimeout(() => {
          this.finishMessage = `正答率${this.showResult}％ タイピングスピード${this.showTypeSpeed}打鍵 / 分`
        }, 100)
        this.loc = 0
        this.typingLank = this.lank

        if(this.playsText == "0 回"){
          this.createUserScore()
        }

        this.updateUserScore()
        
      }
    },

    createUserScore(){
      axios
      .post('/api/user_typings',{
        hi_score: this.showResult,
        hi_speed: this.showTypeSpeed,
        plays: 1
      })
      .then(response => {
        this.userScore.hi_score = response.data.hi_score
        this.userScore.hi_speed = response.data.hi_speed
      })
    },

    updateUserScore(){     
      // ハイスコアだった場合はデーターを更新
      if( this.userScore.hi_score < this.showResult ){
        this.userScore.hi_score = this.showResult
        }

      if( this.userScore.hi_speed < this.showTypeSpeed ) {
        this.userScore.hi_speed = this.showTypeSpeed
      }
      
      this.userScore.plays ++
      axios
      .patch(`/api/user_typings/${this.userScore.id}.json`, {
        hi_score: this.userScore.hi_score,
        hi_speed: this.userScore.hi_speed,
        plays: this.userScore.plays
      })
      .then(response => {
        this.userScore.hi_score = response.data.hi_score
        this.userScore.hi_speed = response.data.hi_speed
      })
 
    }

  },



  computed:{

    currentWord(){

      //unsolvedWordsという定数にthis.words配列から要素を取り出し、代入する
      //取り出す要素はsolvedWordsに含まれていない要素
      const unsolvedWords = this.words.filter((word) => {
        //解答されていないものだけ
        return (!this.solvedWords.includes(word))
      })

      //randomIndexという定数に解答されていない要素の配列番号をランダムで取り出す
      //その数字を使って上の未解答配列unsolvedWordsの要素にアクセスする
      const randomIndex = Math.floor(Math.random() * unsolvedWords.length)
      return unsolvedWords[randomIndex]
    },

    lank(){
      if (this.showResult > 90 || this.showTypeSpeed > 210 ){
        return "Excellent!!"
      }else if(this.showResult > 70 || this.showTypeSpeed > 150 ){
         return "Greate!"     
      }else if(this.showResult > 60 || this.showTypeSpeed > 125 ){
         return "Good"     
      }else if(this.showResult < 124 || this.showTypeSpeed < 150 ){
         return "Go for it!"     
      }
    },

    showResult(){
      return this.goodType + this.missType === 0 ? 0 : (this.goodType / ( this.goodType + this.missType ) * 100).toFixed(1);
    },

    showTypeSpeed(){
      return (this.goodType / ((Date.now() - this.startTime) / 1000)).toFixed(1) * 60;
    },

    hiScoreText(){
      if(this.userScore.hi_score == null){
        return 0 + " %"
      }
      return this.userScore.hi_score + ' %'
    },

    hiSpeedText(){
      if(this.userScore.hi_speed == null){
        return 0 + " 打鍵 / 分"
      }
      return this.userScore.hi_speed + ' 打鍵 / 分'
    },

    playsText(){
      if(this.userScore.plays == null){
        return 0 + "回"
      }
      return this.userScore.plays + ' 回'
    }

  },


  mounted(){
    axios
      .get('/api/words.json')
      .then(response => (this.words = response.data))

  },


  created(){
    axios
      .get(`/api/user_typings/${this.$route.params.id}}.json`)
      .then(response => (this.userScore = response.data))
    window.addEventListener('keydown', this.inputKey);
    
  }   
}
</script>

