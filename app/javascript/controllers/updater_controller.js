import { Controller } from "stimulus";

export default class extends Controller {
	static targets = ["count"];

	connect() {
		setInterval(this.refresh, 5000);
	}

	refresh = () => {
		console.log("test");
		const elementClass = this.votesTarget.classList.value;
		const elementId = parseInt(elementClass.replace(/\D/g, ""), 10);
		const route = [parseInt(this.data.get("community"), 10), elementId];
		const communityId = route[0];
		const postId = route[1];
		const url = `/communities/${communityId}/posts/${postId}`;
		fetch(url, {
			headers: {
				Accept: "application/json",
				"Content-Type": "application/json",
			},
		})
			.then((response) => response.json())
			.then((data) => {
				const updatedScore = data.total_votes;
				console.log(updatedScore);
				console.log(votesTarget);
				this.votesTargets.innerHTML = updatedScore;
			});
	};
}
