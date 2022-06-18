function TagIndicator() {
	
	this.setOwner = (function(value) {
		this.owner = value;
	}).bind(this);
	
	this.getId = (function() {
		return this.value[this.value.selectedIndex].value;
	}).bind(this);
	
	this.appendInputs = (function(form) {
		var input;
		input = document.createElement('input');
	}).bind(this);
	
	this.owner;
	this.groundPanel;
	this.value;
	
	this.construct = (function(datalist) {
		var solvent, solute;
		solute = document.createElement('div');
		this.owner.appendChild(solute);
		solute.style.border = '1px solid black';
		this.groundPanel = solute;
		solute.controller = this;
		solvent = this.groundPanel;
		
/*		
		var list;
		list = document.createElement('datalist');
		list.id = 'values';
		for (var i = 0; i <= datalist.length - 1; i++) {
			list.append(new Option(datalist[i].value, datalist[i].value));
		}
		this.list = list;
		
		solute = document.createElement('input');
		solvent.appendChild(solute);
		solute.type = 'text';
		solute.list = 'values';
*/
		
		solute = document.createElement('select');
		solvent.appendChild(solute);
		for (var i = 0; i <= datalist.length - 1; i++) {
			solute.append(new Option(datalist[i].value, datalist[i].id));
		}
		this.value = solute;
		
		
		console.log(this.value[this.value.selectedIndex].value);
		
	}).bind(this);
}