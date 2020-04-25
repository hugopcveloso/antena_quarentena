import { csrfToken } from "rails-ujs";

import { Controller } from "stimulus";

export default class extends Controller {
  static targets = [ 'score' ]

  connect() {
    const bla = [this.data.get("community");
    setInterval(this.refresh(bla), 5000);
     
  }

  // upvote = () => {
  //   console.log(this.scoreTarget.innerHTML) 
  // }

// the goal is to create the vote from a fetch.  
// I also could try to create a vote from a link, preventDefault
// use the data action from the click to update the view. 

  upvote = (event) => {
    event.preventDefault()
    const elementClass = this.scoreTarget.classList.value
    const elementId = parseInt(elementClass.replace(/\D/g,''),10);

    fetch("/votes", {
      method: "POST", 
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        'X-CSRF-Token': csrfToken(),
      },
      // credentials: "same-origin",
      body: JSON.stringify({ votable_id: elementId, votable_type: "Post", upvote: true })
    })
    .then(response => response.json())
    .then((data) => {
      console.log(this.scoreTarget.innerHTML)
      console.log(data.newvote)
       const active = data.type ? 'active' : ''
      if (data.newvote === true) {
        this.element.children[0].classList.remove("active")
        this.element.children[2].classList.remove("active")
        if (data.type === true) {
          event.target.classList.add("active")
          this.scoreTarget.innerHTML = parseInt(data.all_votes,10)
        } else {
          this.element.children[0].classList.remove("active")
        }
      } else {
        this.scoreTarget.innerHTML = parseInt(data.all_votes,10) - 1
        this.element.children[0].classList.remove("active")
      }
      }
    )
  }
  downvote = (event) => {
    event.preventDefault()
    const elementClass = this.scoreTarget.classList.value
    const elementId = parseInt(elementClass.replace(/\D/g,''),10);

    fetch("/votes", {
      method: "POST", 
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        'X-CSRF-Token': csrfToken(),
      },
      // credentials: "same-origin",
      body: JSON.stringify({ votable_id: elementId, votable_type: "Post", upvote: false })
    })
    .then(response => response.json())
    .then((data) => {
      console.log(this.scoreTarget.innerHTML)
      console.log(data.newvote)
      console.log(parseInt(data.all_votes - 1))
      const active = data.type ? 'active' : ''
      if (data.newvote === true) {
        this.element.children[0].classList.remove("active")
        this.element.children[2].classList.remove("active")
        if (data.type === false) {
          this.element.children[2].classList.add("active")
          this.scoreTarget.innerHTML = parseInt(data.all_votes,10) - 1
        } else {
          this.element.children[2].classList.remove("active") 
        }
      } else {
        this.scoreTarget.innerHTML = parseInt(data.all_votes,10) 
        this.element.children[2].classList.remove("active")
      }
    
    
    })
  }

  refresh = (bla) => {
    console.log(bla)
    // const url = '/communities/${}/posts'
    // fetch('/posts', { headers: { accept: 'application/json' } })
    //   .then(response => response.json())
    //   .then((data) => {
    //     console.log(data)
    //     // this.countTarget.innerText = data.restaurants.length;
    //   });
  }

  


};

  
    

    
  // $("#vote-actions-<%= @post.id %> .score").text("<%= @post.score %>");
  // $("#vote-actions-<%= @post.id %> .downvote, #vote-actions-<%= @post.id%> .upvote").removeClass("active");
  // <% if @new_vote %>
  //   <% if @is_upvote == "true" %>
  //     $("#vote-actions-<%= @post.id %> .upvote").addClass("active");
  //   <% else %>
  //     $("#vote-actions-<%= @post.id %> .downvote").addClass("active");	
  //   <% end %>
  // <% end %>
  