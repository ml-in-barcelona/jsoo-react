type attributeType = String | Int | Float | Bool

type eventType = string

type attribute = {type_: attributeType; name: string; htmlName: string}

type event = {type_: eventType; name: string}

type prop = Attribute of attribute | Event of event

val getHtmlName: prop -> string
val findByName: string -> prop
