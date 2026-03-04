# Mülltrenninator — Datenschutzerklärung

**Gültig ab:** 01.03.2026
**Betreiber / Verantwortlicher:** JHubi1
**Kontakt:** <me@jhubi1.com>
**Standort:** Deutschland

## Kurzübersicht

- Mülltrenninator ist ein kostenloser Webdienst zur Klassifizierung von Abfallbildern mittels KI. Sie laden ein Foto hoch und erhalten eine Vorhersage — kein Konto erforderlich.
- **Keine Benutzerkonten** vorhanden. Es gibt keine Registrierung, keine Anmeldung und keine Authentifizierung.
- Hochgeladene Bilder werden an ein KI-Modell-Backend zur Klassifizierung weitergeleitet und vom Server **nicht gespeichert**.
- Wir erheben oder speichern **keine** personenbezogenen Daten dauerhaft. Keine Cookies, kein Tracking, keine Analyse.
- Ihre **IP-Adresse** wird vorübergehend (nur im Arbeitsspeicher) für die Ratenbegrenzung verwendet und **nicht** auf der Festplatte gespeichert.
- Ihr **Accept-Language**-HTTP-Header wird verwendet, um rechtliche Dokumente in Ihrer bevorzugten Sprache bereitzustellen, und wird **nicht gespeichert**.
- **Server-Logs** (HTTP-Methode, Statuscode, URL-Pfad) werden auf stderr geschrieben und über die Lebensdauer des Serverprozesses hinaus nicht persistent gespeichert, sofern sie nicht von der Hosting-Umgebung erfasst werden.

---

## 1. Verantwortlicher & Kontakt

Verantwortlicher für die über Mülltrenninator durchgeführte Datenverarbeitung ist:

**JHubi1**
E-Mail: **<me@jhubi1.com>**
Standort: Deutschland

Ein Datenschutzbeauftragter (DSB) wurde nicht formell bestellt. Für alle Fragen, Datenschutzanfragen oder zur Ausübung Ihrer Rechte wenden Sie sich bitte an die obige Adresse.

## 2. Kategorien der verarbeiteten personenbezogenen Daten

### 2.1 Von Ihnen hochgeladene Bilder

- Wenn Sie ein Bild zur Klassifizierung hochladen, wird es an ein KI-Modell-Backend (Gradio-basiert) zur Vorhersage weitergeleitet.
- Das Bild wird vom Mülltrenninator-Server **nicht gespeichert**. Der Server fungiert ausschließlich als Proxy.
- Das Modell-Backend kann das Bild vorübergehend im Speicher oder auf der Festplatte halten; es wird nach Abschluss der Vorhersage nicht aufbewahrt.
- Über diesen Dienst werden keine Bilder für das Modelltraining verwendet.

### 2.2 Netzwerkmetadaten (vorübergehend)

| Datum                      | Verwendung                                          | Aufbewahrung                                                                                                                                                                       |
| -------------------------- | --------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **IP-Adresse**             | Ratenbegrenzung (5 Anfragen pro 10 Sekunden pro IP) | **Nur vorübergehend im Arbeitsspeicher** — nicht auf Festplatte geschrieben, nicht persistent; wird gelöscht, wenn das Ratenbegrenzungsfenster abläuft oder der Server neu startet |
| **Accept-Language-Header** | Spracherkennung für rechtliche Dokumente            | **Nicht gespeichert** — wird zum Zeitpunkt der Bereitstellung aus der HTTP-Anfrage gelesen und verworfen                                                                           |

### 2.3 Server-Logs

HTTP-Anfragemethode, Statuscode und URL-Pfad werden zur betrieblichen Überwachung auf stderr protokolliert. Diese Logs enthalten **keine** IP-Adressen, Anfrageinhalte oder andere personenbezogene Daten. Logs werden über die Lebensdauer des Serverprozesses hinaus nicht persistent gespeichert, sofern sie nicht vom Log-Management der Hosting-Umgebung erfasst werden.

### 2.4 Daten, die wir **nicht** erheben

Wir erheben oder speichern nicht: Benutzernamen, E-Mail-Adressen, Passwörter, Cookies, Gerätekennungen, Kontaktlisten, Adressbücher, Zahlungsdaten, Standortdaten, Gesundheitsdaten, biometrische Daten, Tracking-Cookies oder Daten von Analyse- oder Werbe-SDKs. **Es werden keine Cookies oder ähnliche Tracking-Technologien verwendet.**

## 3. Zwecke und Rechtsgrundlagen der Verarbeitung

| Zweck                                                                                                                                          | Betroffene Daten                   | Rechtsgrundlage (Art. 6 DSGVO)                                                                                                                                                |
| ---------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Bildklassifizierung** — Weiterleitung Ihres hochgeladenen Bildes an das KI-Modell-Backend und Rückgabe des Vorhersageergebnisses             | Hochgeladenes Bild (vorübergehend) | **Berechtigte Interessen (Art. 6 Abs. 1 lit. f)** — unser Interesse an der Bereitstellung des Kerndienstes; das Bild wird nur vorübergehend verarbeitet und nicht gespeichert |
| **Sicherheit & Missbrauchsprävention** — Ratenbegrenzung zur Verhinderung übermäßiger Nutzung und Sicherstellung der Dienstverfügbarkeit       | IP-Adresse (vorübergehend)         | **Berechtigte Interessen (Art. 6 Abs. 1 lit. f)** — unser Interesse am Schutz des Dienstes und der Gewährleistung eines fairen Zugangs für alle Nutzer                        |
| **Betriebliche Überwachung** — Protokollierung von HTTP-Anfragemetadaten (Methode, Status, Pfad) zur Fehlersuche und Verfügbarkeitsüberwachung | Server-Log-Einträge                | **Berechtigte Interessen (Art. 6 Abs. 1 lit. f)** — unser Interesse an der Wartung und Fehlerbehebung des Dienstes                                                            |
| **Spracherkennung** — Bereitstellung rechtlicher Dokumente in Ihrer bevorzugten Sprache                                                        | Accept-Language-Header             | **Berechtigte Interessen (Art. 6 Abs. 1 lit. f)** — unser Interesse an der Bereitstellung eines zugänglichen Dienstes                                                         |

Soweit wir uns auf **berechtigte Interessen** stützen, haben wir eine Abwägung durchgeführt und festgestellt, dass die Verarbeitung verhältnismäßig ist und Ihre Rechte nicht überwiegt, da alle Daten nur vorübergehend verarbeitet und keine personenbezogenen Daten dauerhaft gespeichert werden. Sie können Details dieser Bewertung anfordern.

## 4. Datenspeicherung

| Datenkategorie          | Aufbewahrungsdauer                                                                                                                                                 |
| ----------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| **Hochgeladene Bilder** | **Nicht aufbewahrt** — an das Modell-Backend weitergeleitet und verworfen; nicht auf dem Server gespeichert                                                        |
| **IP-Adressen**         | **Nur vorübergehend** — im Arbeitsspeicher für das Ratenbegrenzungsfenster (10 Sekunden) gehalten und verworfen; nicht auf Festplatte geschrieben                  |
| **Server-Logs**         | Auf stderr geschrieben; über die Lebensdauer des Serverprozesses hinaus nicht persistent gespeichert, sofern nicht vom Log-Management der Hosting-Umgebung erfasst |

## 5. Empfänger und Auftragsverarbeiter

| Empfänger               | Geteilte Daten                                        | Zweck                                                      | Standort                 |
| ----------------------- | ----------------------------------------------------- | ---------------------------------------------------------- | ------------------------ |
| **KI-Modell-Backend**   | Hochgeladenes Bild (vorübergehend)                    | Bildklassifizierung / Vorhersage (Gradio-basierter Dienst) | Gleiche Hosting-Umgebung |

Wir **verkaufen keine** personenbezogenen Daten. Es werden keine Daten an Werbe-, Analyse- oder andere Drittanbieterdienste weitergegeben.

## 6. Ihre Rechte nach der DSGVO

Nach der DSGVO haben Sie folgende Rechte, die Sie jederzeit per E-Mail an **<me@jhubi1.com>** ausüben können:

| Recht                              | Beschreibung                                                                                                                                                             |
| ---------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| **Auskunft** (Art. 15)             | Bestätigung, ob wir Ihre Daten verarbeiten, und Erhalt einer Kopie                                                                                                       |
| **Berichtigung** (Art. 16)         | Berichtigung unrichtiger Daten                                                                                                                                           |
| **Löschung** (Art. 17)             | Löschung Ihrer Daten („Recht auf Vergessenwerden")                                                                                                                       |
| **Einschränkung** (Art. 18)        | Einschränkung der Verarbeitung Ihrer Daten unter bestimmten Umständen                                                                                                    |
| **Datenübertragbarkeit** (Art. 20) | Erhalt Ihrer Daten in einem strukturierten, gängigen, maschinenlesbaren Format                                                                                           |
| **Widerspruch** (Art. 21)          | Widerspruch gegen die Verarbeitung aufgrund berechtigter Interessen; wir stellen die Verarbeitung ein, es sei denn, wir können zwingende schutzwürdige Gründe nachweisen |

**Hinweis:** Da Mülltrenninator keine personenbezogenen Daten dauerhaft speichert, sind die meisten dieser Rechte konstruktionsbedingt bereits erfüllt — es gibt keine gespeicherten Daten, auf die zugegriffen, die berichtigt, gelöscht oder übertragen werden könnten.

Wir antworten auf Ihre Anfrage innerhalb **eines Monats** (verlängerbar um zwei weitere Monate bei komplexen Anfragen, mit Benachrichtigung). Die Ausübung Ihrer Rechte ist kostenlos.

## 7. Internationale Datenübermittlungen

Unsere Datenverarbeitung findet ausschließlich innerhalb der EU statt (Hetzner, Deutschland). Es werden keine personenbezogenen Daten außerhalb des Europäischen Wirtschaftsraums (EWR) übermittelt.

## 8. Sicherheitsmaßnahmen

Wir setzen angemessene technische und organisatorische Maßnahmen (Art. 32 DSGVO) zum Schutz des Dienstes um:

- **Ratenbegrenzung:** Maximal 5 Anfragen pro 10 Sekunden pro IP-Adresse zur Missbrauchsprävention
- **Keine dauerhafte Datenspeicherung:** Keine personenbezogenen Daten werden auf der Festplatte gespeichert — Bilder werden vorübergehend weitergeleitet, IP-Adressen nur im Arbeitsspeicher gehalten
- **Verschlüsselung bei Übertragung:** HTTPS (TLS) für alle Verbindungen
- **CORS-Richtlinie:** `Cross-Origin-Embedder-Policy: require-corp`, `Cross-Origin-Opener-Policy: same-origin`
- **Sichere Zufallszahlen:** `Random.secure()` für alle sicherheitsrelevanten Operationen
- **Schutz vor Pfadmanipulation:** Eingabevalidierung aller Dateipfade
- **Log-Hygiene:** Server-Logs enthalten nur HTTP-Methode, Statuscode und URL-Pfad — keine personenbezogenen Daten

Kein System ist absolut sicher. Im unwahrscheinlichen Fall einer Verletzung des Schutzes personenbezogener Daten werden wir die Meldepflichten gemäß Art. 33–34 DSGVO einhalten.

## 9. Automatisierte Entscheidungsfindung

Die KI-Klassifizierung stellt eine automatisierte Verarbeitung dar, erzeugt jedoch **keine** rechtlichen Wirkungen und beeinträchtigt Sie nicht in ähnlicher Weise erheblich (Art. 22 DSGVO). Die Vorhersage ist rein informativ — sie schlägt eine Abfallkategorie vor, trifft aber keine verbindliche Entscheidung über Sie.

## 10. Kinder und Minderjährige

Mülltrenninator erhebt keine personenbezogenen Daten und erfordert keine Registrierung. Daher gibt es keine spezifischen Altersbeschränkungen für die Nutzung des Dienstes. Eltern und Erziehungsberechtigte sollten jedoch die Internetnutzung Minderjähriger generell beaufsichtigen.

## 11. Beschwerden und Aufsichtsbehörde

Wenn Sie der Ansicht sind, dass unsere Verarbeitung Ihrer personenbezogenen Daten gegen die DSGVO verstößt, haben Sie das Recht, Beschwerde bei einer Aufsichtsbehörde einzulegen (Art. 77 DSGVO), insbesondere in dem EU-Mitgliedstaat Ihres gewöhnlichen Aufenthalts, Ihres Arbeitsplatzes oder des Ortes des mutmaßlichen Verstoßes.

In Deutschland können Sie sich an die zuständige Landesdatenschutzbehörde (Landesdatenschutzbeauftragte/r) oder den Bundesbeauftragten für den Datenschutz und die Informationsfreiheit (**BfDI**) für Bundesangelegenheiten wenden. Die Einreichung einer Beschwerde ist kostenlos.

## 12. Änderungen dieser Datenschutzerklärung

Wir können diese Erklärung von Zeit zu Zeit aktualisieren. Wesentliche Änderungen werden auf der Website mitgeteilt. Das Wirksamkeitsdatum am Anfang dieses Dokuments spiegelt stets die aktuelle Version wider. Die fortgesetzte Nutzung des Dienstes nach Änderungen gilt als Kenntnisnahme der aktualisierten Erklärung.

## 13. Kontakt

Für Fragen, Datenschutzanfragen, Betroffenenrechte oder sonstige Anliegen:

**JHubi1**
E-Mail: **<me@jhubi1.com>**
