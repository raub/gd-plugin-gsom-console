@tool
extends Control

const _sceneConsole: PackedScene = preload("./console.tscn")
var _inst: Control = null;


var _blur: float = 0.5;
@export_range(0.0, 1.0) var blur: float = 0.6:
	get:
		return _blur;
	set(v):
		_blur = v;
		_assignBlur();

var _color: Color = Color(0.0, 0.0, 0.0, 0.3);
@export var color: Color = Color(0.0, 0.0, 0.0, 0.3):
	get:
		return _color;
	set(v):
		_color = v;
		_assignColor();


var _labelWindow: String = "Console";
@export var labelWindow: String = "Console":
	get:
		return _labelWindow;
	set(v):
		if _labelWindow == v:
			return;
		_labelWindow = v;
		_assignLabelWindow();


var _labelSubmit: String = "submit";
@export var labelSubmit: String = "submit":
	get:
		return _labelSubmit;
	set(v):
		if _labelSubmit == v:
			return;
		_labelSubmit = v;
		_assignLabelSubmit();


func _assignLabelWindow() -> void:
	if _inst:
		_inst.get_node("Panel/ColumnMain/RowTitle/LabelTitle").text = _labelWindow;


func _assignLabelSubmit() -> void:
	if _inst:
		_inst.get_node("Panel/ColumnMain/RowInput/ButtonSubmit").text = _labelSubmit;


func _assignBlur() -> void:
	if !_inst:
		return;
	
	_inst.get_node("Panel/Blur").material.set_shader_parameter("blur", _blur * 5.0);


func _assignColor() -> void:
	if !_inst:
		return;
	
	_inst.get_node("Panel/Blur").material.set_shader_parameter("color", _color);


func _ready() -> void:
	self.custom_minimum_size = Vector2(480, 320);
	_inst = _sceneConsole.instantiate();
	add_child(_inst);
	
	var blurPanel: Control = _inst.get_node("Panel/Blur");
	blurPanel.material = blurPanel.material.duplicate(true);
	
	_assignBlur();
	_assignColor();
	_assignLabelWindow();
	_assignLabelSubmit();
