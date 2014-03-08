function $(id) { return document.getElementById(id); }

onload = function() {

	$('anchoTrazo').oninput = function(){ 
		$('anchoTrazo-out').innerHTML = this.value;
		var pjs = Processing.getInstanceById('PaperLager');
		pjs.updateAnchoTrazo(this.value);
	};

	$('anchoTrama').oninput = function(){ 
		$('anchoTrama-out').innerHTML = this.value;
		var pjs = Processing.getInstanceById('PaperLager');
		pjs.updateAnchoTrama(this.value);
	};


}; 





function addNoise(){
	var pjs = Processing.getInstanceById('PaperLager');
	pjs.addNoise();
}

function reset(){
	var pjs = Processing.getInstanceById('PaperLager');
	pjs.setup();
}

$('anchoTrama').oninput();
$('anchoTrazo').oninput();