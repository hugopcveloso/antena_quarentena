import { csrfToken } from "rails-ujs";

import { Controller } from "stimulus";

export default class extends Controller {
	static targets = ["score"];

	upvote = (event) => {
		const elementClass = this.scoreTarget.classList.value;
		const elementId = parseInt(elementClass.replace(/\D/g, ""), 10);

		const votableType = this.data.get("type");
		fetch("/votes", {
			method: "POST",
			headers: {
				Accept: "application/json",
				"Content-Type": "application/json",
				"X-CSRF-Token": csrfToken(),
			},
			body: JSON.stringify({
				votable_id: elementId,
				votable_type: votableType,
				upvote: true,
			}),
		})
			.then((response) => response.json())
			.then((data) => {
				this.element.children[0].classList.remove("active");
				this.element.children[2].classList.remove("active");
				if (data.newvote === true) {
					if (data.type === true) {
						console.log(event.target.classList);
						event.target.classList.add("active");
						this.scoreTarget.innerHTML = parseInt(data.all_votes, 10);
					}
				} else {
					const typeOfVote = data.last_vote ? -1 : 0;
					this.scoreTarget.innerHTML =
						parseInt(data.all_votes, 10) + typeOfVote;
				}
			});
	};
	downvote = (event) => {
		const elementClass = this.scoreTarget.classList.value;
		const elementId = parseInt(elementClass.replace(/\D/g, ""), 10);
		const votableType = this.data.get("type");

		fetch("/votes", {
			method: "POST",
			headers: {
				Accept: "application/json",
				"Content-Type": "application/json",
				"X-CSRF-Token": csrfToken(),
			},
			body: JSON.stringify({
				votable_id: elementId,
				votable_type: votableType,
				upvote: false,
			}),
		})
			.then((response) => response.json())
			.then((data) => {
				this.element.children[0].classList.remove("active");
				this.element.children[2].classList.remove("active");
				const active = data.type ? "active" : "";
				if (data.newvote === true) {
					if (data.type === false) {
						event.target.classList.add("active");
						console.log(this.element.children[2]);
						this.scoreTarget.innerHTML = parseInt(data.all_votes, 10) - 1;
					}
				} else {
					const typeOfVote = data.last_vote ? -1 : 0;
					this.scoreTarget.innerHTML =
						parseInt(data.all_votes, 10) + typeOfVote;
				}
			});
	};
}
