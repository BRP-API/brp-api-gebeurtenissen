# BRP API Gebeurtenissen

## Known Issue

De OpenAPI Generator voegt het `override` keyword niet toe aan de Kotlin data classes voor objecten die gebruik maken van inheritance met `allOf`.

Vergelijkbaar issue: [OpenAPI Generator Issue #15155](https://github.com/OpenAPITools/openapi-generator/issues/15155)

Als (tijdelijke) oplossing is het veld `data` verwijderd uit het object `Event` zodat het override keyword niet meer nodig is.