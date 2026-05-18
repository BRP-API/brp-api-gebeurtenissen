package main

import (
	"context"
	"encoding/json"
	"fmt"
	"net/http"
	"strings"
	"testing"

	openapi "github.com/GIT_USER_ID/GIT_REPO_ID"
)

func logPrettyJSON(t *testing.T, label string, v any) {
	t.Helper()

	b, err := json.MarshalIndent(v, "", "  ")
	if err != nil {
		t.Logf("%s: <failed to marshal for logging: %v>", label, err)
		return
	}

	t.Logf("%s:\n%s", label, string(b))
}

func valideerBurgerservicenummerHeeftWaarde(t *testing.T, burgerservicenummer string) {
	t.Helper()

	if burgerservicenummer == "" {
		t.Fatalf("verwachting: burgerservicenummer veld is niet leeg")
	}
}

func valideerLangFormaatHeeftWaarde(t *testing.T, langFormaat string) {
	t.Helper()

	if langFormaat == "" {
		t.Fatalf("verwachting: langFormaat veld is niet leeg")
	}
}

func valideerAdditionalPropertiesIsLeeg(t *testing.T, additionalProperties map[string]interface{}) {
	t.Helper()

	if len(additionalProperties) > 0 {
		t.Fatalf("verwachting: additionalProperties veld is leeg")
	}
}

func valideerVolledigeDatumHeeftAlleVerplichteVelden(t *testing.T, datum *openapi.VolledigeDatum) {
	t.Helper()

	if datum.Datum == "" {
		t.Fatalf("verwachting: datum veld is niet leeg")
	}
	valideerLangFormaatHeeftWaarde(t, datum.LangFormaat)
	valideerAdditionalPropertiesIsLeeg(t, datum.AdditionalProperties)
}

func valideerJaarMaandDatumHeeftAlleVerplichteVelden(t *testing.T, datum *openapi.JaarMaandDatum) {
	t.Helper()

	if datum.Jaar == 0 {
		t.Fatalf("verwachting: jaar veld is niet leeg")
	}
	if datum.Maand == 0 {
		t.Fatalf("verwachting: maand veld is niet leeg")
	}
	valideerLangFormaatHeeftWaarde(t, datum.LangFormaat)
	valideerAdditionalPropertiesIsLeeg(t, datum.AdditionalProperties)
}

func valideerJaarDatumHeeftAlleVerplichteVelden(t *testing.T, datum *openapi.JaarDatum) {
	t.Helper()

	if datum.Jaar == 0 {
		t.Fatalf("verwachting: jaar veld is niet leeg")
	}
	valideerLangFormaatHeeftWaarde(t, datum.LangFormaat)
	valideerAdditionalPropertiesIsLeeg(t, datum.AdditionalProperties)
}

func valideerDatumOnbekendHeeftAlleVerplichteVelden(t *testing.T, datum *openapi.DatumOnbekend) {
	t.Helper()

	if datum.Onbekend == false {
		t.Fatalf("verwachting: onbekend veld bevat waarde true")
	}
	valideerLangFormaatHeeftWaarde(t, datum.LangFormaat)
	valideerAdditionalPropertiesIsLeeg(t, datum.AdditionalProperties)
}

func valideerAbstractDatumHeeftAlleVerplichteVelden(t *testing.T, datum openapi.AbstractDatum) {
	typedDatum := castAbstractDatumByType(t, datum)

	switch d := typedDatum.(type) {
	case *openapi.VolledigeDatum:
		valideerVolledigeDatumHeeftAlleVerplichteVelden(t, d)
	case *openapi.JaarMaandDatum:
		valideerJaarMaandDatumHeeftAlleVerplichteVelden(t, d)
	case *openapi.JaarDatum:
		valideerJaarDatumHeeftAlleVerplichteVelden(t, d)
	case *openapi.DatumOnbekend:
		valideerDatumOnbekendHeeftAlleVerplichteVelden(t, d)
	}
}

func valideerGebeurtenisHeeftAlleVerplichteCloudEventsVelden(t *testing.T, gebeurtenis openapi.Gebeurtenis) {
	t.Helper()

	if gebeurtenis.GetId() == "" {
		t.Fatalf("verwachting: id veld is niet leeg")
	}
	if gebeurtenis.GetSource() != "brp-api-gebeurtenissen" {
		t.Fatalf("verwachting: source veld bevat waarde 'brp-api-gebeurtenissen', maar bevat waarde %s'", gebeurtenis.GetSource())
	}
	if gebeurtenis.GetSpecversion() != "1.0" {
		t.Fatalf("verwachting: specversion veld bevat waarde '1.0', maar bevat waarde %s", gebeurtenis.GetSpecversion())
	}
}

func valideerVerhuisdIntergemeentelijkGebeurtenisHeeftAlleVerplichteVelden(t *testing.T, gebeurtenis *openapi.VerhuisdIntergemeentelijk, index int) {
	t.Helper()

	logPrettyJSON(t, fmt.Sprintf("VerhuisdIntergemeentelijk gebeurtenis[%d]", index), gebeurtenis)

	valideerGebeurtenisHeeftAlleVerplichteCloudEventsVelden(t, gebeurtenis.Gebeurtenis)

	data := gebeurtenis.Data

	valideerBurgerservicenummerHeeftWaarde(t, data.GetBurgerservicenummer())

	valideerAbstractDatumHeeftAlleVerplichteVelden(t, data.Verblijfplaats.GetDatumVan())
}

func valideerVerhuisdNaarBuitenlandGebeurtenisHeeftAlleVerplichteVelden(t *testing.T, gebeurtenis *openapi.VerhuisdNaarBuitenland, index int) {
	t.Helper()

	logPrettyJSON(t, fmt.Sprintf("VerhuisdNaarBuitenland gebeurtenis[%d]", index), gebeurtenis)

	valideerGebeurtenisHeeftAlleVerplichteCloudEventsVelden(t, gebeurtenis.Gebeurtenis)

	data := gebeurtenis.Data

	valideerBurgerservicenummerHeeftWaarde(t, data.GetBurgerservicenummer())

	valideerAbstractDatumHeeftAlleVerplichteVelden(t, data.Verblijfplaats.GetDatumVan())
}

func valideerOverledenGebeurtenisHeeftAlleVerplichteVelden(t *testing.T, gebeurtenis *openapi.Overleden, index int) {
	t.Helper()

	logPrettyJSON(t, fmt.Sprintf("Overleden gebeurtenis[%d]", index), gebeurtenis)

	valideerGebeurtenisHeeftAlleVerplichteCloudEventsVelden(t, gebeurtenis.Gebeurtenis)

	data := gebeurtenis.Data

	valideerBurgerservicenummerHeeftWaarde(t, data.GetBurgerservicenummer())

	valideerAbstractDatumHeeftAlleVerplichteVelden(t, data.Overlijden.GetDatum())
}

func valideerGebeurtenisHeeftAlleVerplichteVelden(t *testing.T, gebeurtenis openapi.Gebeurtenis, i int) {
	t.Helper()

	switch typedGebeurtenis := castGebeurtenisByType(t, gebeurtenis, i).(type) {
	case *openapi.VerhuisdIntergemeentelijk:
		valideerVerhuisdIntergemeentelijkGebeurtenisHeeftAlleVerplichteVelden(t, typedGebeurtenis, i)
	case *openapi.VerhuisdNaarBuitenland:
		valideerVerhuisdNaarBuitenlandGebeurtenisHeeftAlleVerplichteVelden(t, typedGebeurtenis, i)
	case *openapi.Overleden:
		valideerOverledenGebeurtenisHeeftAlleVerplichteVelden(t, typedGebeurtenis, i)
	default:
		t.Fatalf("Unexpected type: %v", typedGebeurtenis)
	}
}

func toConcreteAbstractDatum[T any](datum openapi.AbstractDatum) (*T, error) {
	raw, err := json.Marshal(datum)
	if err != nil {
		return nil, fmt.Errorf("failed to marshal abstractDatum: %v", err)
	}

	var typedDatum T
	if err := json.Unmarshal(raw, &typedDatum); err != nil {
		return nil, fmt.Errorf("failed to unmarshal abstractDatum: %v", err)
	}

	return &typedDatum, nil
}

func castAbstractDatumByType(t *testing.T, datum openapi.AbstractDatum) any {
	t.Helper()

	switch strings.ToLower(datum.Type) {
	case "datum":
		d, err := toConcreteAbstractDatum[openapi.VolledigeDatum](datum)
		if err != nil {
			t.Fatalf("failed to cast abstractDatum: %v", err)
		}
		return d
	case "jaarmaanddatum":
		d, err := toConcreteAbstractDatum[openapi.JaarMaandDatum](datum)
		if err != nil {
			t.Fatalf("failed to cast abstractDatum: %v", err)
		}
		return d
	case "jaardatum":
		d, err := toConcreteAbstractDatum[openapi.JaarDatum](datum)
		if err != nil {
			t.Fatalf("failed to cast abstractDatum: %v", err)
		}
		return d
	case "datumonbekend":
		d, err := toConcreteAbstractDatum[openapi.DatumOnbekend](datum)
		if err != nil {
			t.Fatalf("failed to cast abstractDatum: %v", err)
		}
		return d
	default:
		t.Fatalf("unknown abstractDatum type: %s", datum.Type)
		return nil
	}
}

func toConcreteGebeurtenis[T any](gebeurtenis openapi.Gebeurtenis) (*T, error) {
	raw, err := json.Marshal(gebeurtenis)
	if err != nil {
		return nil, fmt.Errorf("failed to marshal gebeurtenis: %v", err)
	}

	var typedGebeurtenis T
	if err := json.Unmarshal(raw, &typedGebeurtenis); err != nil {
		return nil, fmt.Errorf("failed to unmarshal gebeurtenis: %v", err)
	}

	return &typedGebeurtenis, nil
}

func castGebeurtenisByType(t *testing.T, gebeurtenis openapi.Gebeurtenis, index int) any {
	t.Helper()

	switch strings.ToLower(gebeurtenis.Type) {
	case "nl.brp.verhuisd.intergemeentelijk":
		g, err := toConcreteGebeurtenis[openapi.VerhuisdIntergemeentelijk](gebeurtenis)
		if err != nil {
			t.Fatalf("failed to cast gebeurtenis: %v", err)
		}
		return g
	case "nl.brp.verhuisd.naar-buitenland":
		g, err := toConcreteGebeurtenis[openapi.VerhuisdNaarBuitenland](gebeurtenis)
		if err != nil {
			t.Fatalf("failed to cast gebeurtenis: %v", err)
		}
		return g
	case "nl.brp.overleden":
		g, err := toConcreteGebeurtenis[openapi.Overleden](gebeurtenis)
		if err != nil {
			t.Fatalf("failed to cast gebeurtenis: %v", err)
		}
		return g
	default:
		t.Fatalf("unknown gebeurtenis type: %s", gebeurtenis.Type)
		return nil
	}
}

func valideerHttpResponse(t *testing.T, httpResponse *http.Response) {
	if httpResponse == nil {
		t.Fatalf("HTTP Response is nil")
	}
	if httpResponse.StatusCode != 200 {
		t.Fatalf("HTTP Status Code is not 200: %d", httpResponse.StatusCode)
	}
}

func valideerResponse(t *testing.T, response *openapi.GebeurtenissenBevragenResponse) {
	if response == nil {
		t.Fatalf("Response is nil")
	}
}

func bevraagGebeurtenissen(t *testing.T) []openapi.Gebeurtenis {
	cfg := openapi.NewConfiguration()
	cfg.Servers = openapi.ServerConfigurations{
		{
			URL: "http://localhost:8080",
		},
	}
	client := openapi.NewAPIClient(cfg)

	response, httpResponse, err := client.GebeurtenissenAPI.BevraagGebeurtenis(context.Background(), "test").Execute()
	if err != nil {
		t.Fatalf("BevraagGebeurtenis failed: %v", err)
	}
	valideerHttpResponse(t, httpResponse)
	valideerResponse(t, response)

	return response.Gebeurtenissen
}

func TestBevraagGebeurtenissen(t *testing.T) {
	gebeurtenissen := bevraagGebeurtenissen(t)

	logPrettyJSON(t, "Gebeurtenissen", gebeurtenissen)

	if len(gebeurtenissen) == 0 {
		t.Fatalf("No Gebeurtenissen")
	}

	for i, gebeurtenis := range gebeurtenissen {
		valideerGebeurtenisHeeftAlleVerplichteVelden(t, gebeurtenis, i)
	}
}
