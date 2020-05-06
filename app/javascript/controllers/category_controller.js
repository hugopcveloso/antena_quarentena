import { Controller } from 'stimulus';

export default class extends Controller {
	static targets = [ 'checkbox', 'tags' ];

	connect() {
		console.log('hello G', this.checkboxTargets);
	}

	checking = (event) => {
		const clickedTag = event.target;
		const elementId = parseInt(event.target.id.replace(/\D/g, ''), 10) - 1;
		const boxToCheck = this.checkboxTargets[elementId];

		if (clickedTag.classList.contains('active-category')) {
			clickedTag.classList.remove('active-category');
			boxToCheck.checked = false;
		} else {
			clickedTag.classList.add('active-category');
			boxToCheck.checked = true;
		}
	};
}
