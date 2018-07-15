import Vue from 'vue';
import {Socket, Presence} from "phoenix";

const container = document.querySelector("#player-summary");

Vue.config.productionTip = false;

if (container) {
  new Vue({
    el: "#game",
    methods: {
      joinChannel() {
        const socket = new Socket("/socket")
        socket.connect()

        this.channel = socket.channel("counter:update", {})

        this.channel.on("player_adjusted", summary => {
          this.players = summary.game
        })

        this.channel.on("player_joined", summary => {
          this.players = summary.game
        })

        this.channel.on("game_summary", summary => {
          this.players = summary.game
        })

        this.channel.on("player_left", summary => {
          this.players = summary.game
        })

        this.channel.on("player_reset", summary => {
          this.players = summary.game
        })

        this.channel.join()
          .receive("ok", response => {
            console.log("Joined channel")
          })
          .receive("error", response => {
            console.log("ERROR", response)
          })
      },
      adjustDown(player) {
        this.channel.push('adjust_player', {"name": player, adjustment: -1})
          .receive('ok', resp => { this.players = resp.game })
      },
      adjustUp(player) {
        this.channel.push('adjust_player', {"name": player, adjustment: 1})
          .receive('ok', resp => { this.players = resp.game })
      },
      leaveGame(player) {
        this.channel.push('player_leaving', {"name": player})
          .receive('ok', resp => {
            window.location.replace("/sessions/new")
          })
      },
      resetPlayer(player) {
        this.channel.push('reset_player', {"name": player})
          .receive('ok', resp => {
            this.players = resp.game })
      },
    },
    mounted() {
      this.joinChannel()
    },
    data() {
      return {
        players: []
      }
    }
  });
}
