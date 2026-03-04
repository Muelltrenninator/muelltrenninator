# Mülltrenninator — Privacy Policy

**Effective date:** 2026-03-01
**Maintainer / Controller:** JHubi1
**Contact:** <me@jhubi1.com>
**Location:** Germany

## Quick summary

- Mülltrenninator is a free web service for classifying waste images using AI. You upload a photo and receive a prediction — no account required.
- **No user accounts** exist. There is no registration, login, or authentication.
- Uploaded images are forwarded to an AI model backend for classification and are **not stored** by the server.
- We do **not** collect or store any personal data persistently. No cookies, no tracking, no analytics.
- Your **IP address** is used transiently (in-memory only) for rate limiting and is **not stored** on disk.
- Your **Accept-Language** HTTP header is used to serve legal documents in your preferred language and is **not stored**.
- **Server logs** (HTTP method, status code, URL path) are written to stderr and are not persisted beyond the server process lifetime unless captured by the hosting environment.

---

## 1. Controller & contact

The data controller for all processing carried out via Mülltrenninator is:

**JHubi1**
Email: **<me@jhubi1.com>**
Location: Germany

No Data Protection Officer (DPO) has been formally appointed. For all questions, privacy requests, or to exercise your rights, contact the address above.

## 2. Categories of personal data we process

### 2.1 Images you upload

- When you upload an image for classification, it is forwarded to an AI model backend (Gradio-based) for prediction.
- The image is **not stored** by the Mülltrenninator server. The server acts solely as a proxy.
- The model backend may temporarily hold the image in memory or on disk during processing; it is not retained after the prediction is complete.
- No images are used for model training through this service.

### 2.2 Network metadata (transient)

| Data                       | Where used                                       | Retained                                                                                                                                  |
| -------------------------- | ------------------------------------------------ | ----------------------------------------------------------------------------------------------------------------------------------------- |
| **IP address**             | Rate limiting (5 requests per 10 seconds per IP) | **Transiently in memory only** — not written to disk, not persisted; cleared when the rate-limiting window expires or the server restarts |
| **Accept-Language header** | Language detection for legal documents           | **Not stored** — read from the HTTP request at the time of serving and discarded                                                          |

### 2.3 Server logs

HTTP request method, status code, and URL path are logged to stderr for operational monitoring. These logs do **not** contain IP addresses, request bodies, or other personal data. Logs are not persisted beyond the server process lifetime unless captured by the hosting environment's log management.

### 2.4 Data we do **not** collect

We do not collect or store: usernames, email addresses, passwords, cookies, device identifiers, contact lists, address books, payment data, location data, health data, biometric data, tracking cookies, or any data from analytics or advertising SDKs. **No cookies or similar tracking technologies are used.**

## 3. Purposes and legal bases for processing

| Purpose                                                                                                                     | Data involved              | Legal basis (Art. 6 GDPR)                                                                                                                    |
| --------------------------------------------------------------------------------------------------------------------------- | -------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------- |
| **Image classification** — forwarding your uploaded image to the AI model backend and returning the prediction result       | Uploaded image (transient) | **Legitimate interests (Art. 6(1)(f))** — our interest in providing the core service; the image is processed only transiently and not stored |
| **Security & abuse prevention** — rate limiting to prevent excessive use and ensure service availability                    | IP address (transient)     | **Legitimate interests (Art. 6(1)(f))** — our interest in protecting the service and ensuring fair access for all users                      |
| **Operational monitoring** — logging HTTP request metadata (method, status, path) for debugging and availability monitoring | Server log entries         | **Legitimate interests (Art. 6(1)(f))** — our interest in maintaining and troubleshooting the service                                        |
| **Language detection** — serving legal documents in your preferred language                                                 | Accept-Language header     | **Legitimate interests (Art. 6(1)(f))** — our interest in providing an accessible service                                                    |

Where we rely on **legitimate interests**, we have conducted a balancing test and determined that the processing is proportionate and does not override your rights, given that all data is processed transiently and no personal data is stored persistently. You may request details of this assessment.

## 4. Data retention

| Data category       | Retention period                                                                                                                |
| ------------------- | ------------------------------------------------------------------------------------------------------------------------------- |
| **Uploaded images** | **Not retained** — forwarded to the model backend and discarded; not stored on the server                                       |
| **IP addresses**    | **Transient only** — held in memory for the rate-limiting window (10 seconds) and discarded; not written to disk                |
| **Server logs**     | Written to stderr; not persisted beyond the server process lifetime unless captured by the hosting environment's log management |

## 5. Recipients and subprocessors

| Recipient               | Data shared                                      | Purpose                                                  | Location                 |
| ----------------------- | ------------------------------------------------ | -------------------------------------------------------- | ------------------------ |
| **AI model backend**    | Uploaded image (transient)                       | Image classification / prediction (Gradio-based service) | Same hosting environment |

We do **not** sell personal data. No data is shared with advertising, analytics, or other third-party services.

## 6. Your rights under the GDPR

Under the GDPR you have the following rights, which you can exercise at any time by contacting **<me@jhubi1.com>**:

| Right                          | Description                                                                                                                      |
| ------------------------------ | -------------------------------------------------------------------------------------------------------------------------------- |
| **Access** (Art. 15)           | Obtain confirmation of whether we process your data and receive a copy of it                                                     |
| **Rectification** (Art. 16)    | Have inaccurate data corrected                                                                                                   |
| **Erasure** (Art. 17)          | Request deletion of your data ("right to be forgotten")                                                                          |
| **Restriction** (Art. 18)      | Request that we restrict processing of your data in certain circumstances                                                        |
| **Data portability** (Art. 20) | Receive your data in a structured, commonly used, machine-readable format                                                        |
| **Objection** (Art. 21)        | Object to processing based on legitimate interests; we will cease processing unless we demonstrate compelling legitimate grounds |

**Note:** Since Mülltrenninator does not store any personal data persistently, most of these rights are effectively satisfied by design — there is no stored data to access, rectify, erase, or port.

We will respond to your request within **one month** (extendable by two further months for complex requests, with notification). Exercising your rights is free of charge.

## 7. International data transfers

Our data processing takes place exclusively within the EU (Hetzner, Germany). No personal data is transferred outside the European Economic Area (EEA).

## 8. Security measures

We implement appropriate technical and organisational measures (Art. 32 GDPR) to protect the service:

- **Rate limiting:** Maximum 5 requests per 10 seconds per IP address to prevent abuse
- **No persistent data storage:** No personal data is stored on disk — images are forwarded transiently, IP addresses are held only in memory
- **Encryption in transit:** HTTPS (TLS) for all connections
- **CORS policy:** `Cross-Origin-Embedder-Policy: require-corp`, `Cross-Origin-Opener-Policy: same-origin`
- **Secure randomness:** `Random.secure()` used for all security-sensitive operations
- **Path traversal prevention:** Input validation on all file paths
- **Log hygiene:** Server logs contain only HTTP method, status code, and URL path — no personal data

No system is absolutely secure. In the unlikely event of a personal data breach, we will comply with the notification obligations under Arts. 33–34 GDPR.

## 9. Automated decision-making

The AI classification constitutes automated processing, but it does **not** produce legal effects or similarly significantly affect you (Art. 22 GDPR). The prediction is purely informational — it suggests a waste category but does not make any binding decision about you.

## 10. Children and minors

Mülltrenninator does not collect personal data and does not require registration. As such, there are no specific age restrictions for using the service. However, parents and guardians should supervise minors' internet use in general.

## 11. Complaints and supervisory authority

If you believe our processing of your personal data infringes the GDPR, you have the right to lodge a complaint with a supervisory authority (Art. 77 GDPR), in particular in the EU Member State of your habitual residence, place of work, or place of the alleged infringement.

In Germany, you may contact the relevant state data protection authority (Landesdatenschutzbeauftragte) or the Federal Commissioner for Data Protection and Freedom of Information (**BfDI**) for federal matters. Filing a complaint is free of charge.

## 12. Changes to this Privacy Policy

We may update this policy from time to time. Material changes will be communicated on the website. The effective date at the top of this document will always reflect the latest version. Continued use of the service after changes constitutes acknowledgement of the updated policy.

## 13. Contact

For questions, privacy requests, data subject rights, or any other matters:

**JHubi1**
Email: **<me@jhubi1.com>**
