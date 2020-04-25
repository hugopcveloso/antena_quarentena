import { Controller } from "stimulus"
export default class extends Controller {
  static targets = [ 'votes' ]

  connect() {

    console.log('bla')
    this.load()
    
    if (this.data.has("refreshInterval")) {
      this.startRefreshing()
    }
  }

  disconnect() {
    this.stopRefreshing()
  }

  load() {
    const elementClass = this.votesTarget.classList.value
    const elementId = parseInt(elementClass.replace(/\D/g,''),10);
    const route = [parseInt(this.data.get("community"),10), elementId]
    const communityId = route[0]
    const postId = route[1]
    const url = `/communities/${communityId}/posts/${postId}`
    fetch(url, {
       headers: {
          'Accept': 'application/json',
          "Content-Type": "application/json",
        } })
      .then(response => response.json())
      .then((data) => {
       const updatedScore = data.total_votes
       console.log(updatedScore)
       console.log(votesTarget)
        this.votesTarget.innerHTML = updatedScore
      });
  }

  startRefreshing() {
    this.refreshTimer = setInterval(() => {
      this.load()
    }, this.data.get("refreshInterval"))
  }

  stopRefreshing() {
    if (this.refreshTimer) {
      clearInterval(this.refreshTimer)
    }
  }
}