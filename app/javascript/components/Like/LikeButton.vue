<template>
  <div id="like">
    <div v-if="isLiked" @click="deleteLike()" class="liked">
      Good Nurse {{ count }}
    </div>
    <div v-else @click="registerLike()" class="like">
      Good Nurse {{ count }}
    </div>
  </div>
</template>

<script>
// axios と rails-ujsのメソッドインポート
import axios from 'axios'
import { csrfToken } from 'rails-ujs'
// CSRFトークンの取得とリクエストヘッダへの設定をしてくれます
axios.defaults.headers.common['X-CSRF-TOKEN'] = csrfToken()

export default {
  // propsでrailsのviewからデータを受け取る
  props: ['userId', 'blogId'],
  data() {
    return {
      likeList: []  // いいね一覧を格納するための変数　{ id: 1, user_id: 1, blog_id: 1 } がArrayで入る
    }
  },
  computed: {
    // いいね数を返す
    count() {
      return this.likeList.length
    },
    // ログインユーザが既にいいねしているかを判定する
    //返ってきたlie.idをBooleamでtrue or falseに分別
    isLiked() {
      if (this.likeList.length === 0) { return false }
      return Boolean(this.findLikeId())
    }
  },
  // Vueインスタンスの作成・初期化直後に実行される
  created: function() {
    this.fetchLikeByBlogId().then(result => {
      this.likeList = result
    })
  },
  methods: {
    // rails側のindexアクションにリクエストするメソッド
    fetchLikeByBlogId: async function() {
      const res = await axios.get(`/api/likes/?blog_id=${this.blogId}`)
      if (res.status !== 200) { process.exit() }
      return res.data
    },
    // rails側のcreateアクションにリクエストするメソッド
    registerLike: async function() {
      const res = await axios.post('/api/likes', { blog_id: this.blogId })
      if (res.status !== 201) { process.exit() }
      this.fetchLikeByBlogId().then(result => {
        this.likeList = result
      })
    },
    // rails側のdestroyアクションにリクエストするメソッド
    deleteLike: async function() {
      const likeId = this.findLikeId()
      const res = await axios.delete(`/api/likes/${likeId}`)
      if (res.status !== 200) { process.exit() }
      this.likeList = this.likeList.filter(n => n.id !== likeId)
    },
    // ログインユーザがいいねしているlikeモデルのidを返す
    //likeListのなかでいいねしているユーザーのIDとpropsで取得したuserIdが一致する人を取得し、likeに代入。
    //もしlikeがtrueであればlike.idを返してね→それをislikedメソッドに変換
    findLikeId: function() {
      const like = this.likeList.find((like) => like.user_id === 29)
      // { return (like.user_id === this.userId)
      // })
      if (like) { return like.id }
    }
  }
}
</script>