# Soil Companion (Natural Language Querying)

**Current version:** 1.2.x

**Project:** [Soil Companion](https://github.com/soilwise-he/UC1-C2-chatbot)

## Introduction

<img width="1547" height="1045" alt="Screenshot 2026-01-19 at 12 44 57" src="https://github.com/user-attachments/assets/72b5a7a4-9683-41b0-90a4-fddb59559c36" />

### Component Overview and Scope

The Soil Companion is an AI chatbot developed in the SoilWise project. It provides an intelligent conversational interface through which users can explore European soil metadata, query global and country-specific soil data services, and receive answers grounded in the SoilWise knowledge repository.

The chatbot uses an **agentic tool-calling** approach: a large language model (LLM) autonomously decides which external data sources to consult for each question, executes the relevant tool calls, and synthesizes the results into a coherent response. Answers are enriched with auto-generated links to SoilWise vocabulary terms and Wikipedia articles. A sidebar **Insight** panel displays related SKOS vocabulary concepts and clickable chips that allow users to explore connected topics.

## Users

The Soil Companion targets the following user groups:

- **Soil scientists and researchers** working with European soil health data and seeking catalogued knowledge, publications, and datasets from the SoilWise repository.
- **Agricultural experts and extension officers** looking for soil property data, field-level KPIs, and crop information to inform land management decisions.
- **Students and educators** exploring soil science concepts through a conversational interface that provides definitions, vocabulary hierarchies, and links to authoritative sources.
- **Farmers and land managers** (in selected regions) who want accessible field-level agricultural data such as crop history, soil physical properties, and greenness indices.

Authentication is currently limited to a configurable demo mode (single account) suitable for development and demonstration purposes.

## Requirements

### Functional Requirements

The Soil Companion currently provides the following capabilities:

- **SoilWise Catalog Search** — Searches datasets and knowledge/publications in the SoilWise catalog via Solr, using boosted field relevance ranking. Optionally includes full-text snippets from harvested PDF content. Creates verified back-links to catalog items by identifier.
- **ISRIC SoilGrids** — Queries the ISRIC SoilGrids v2.0 REST API for indicative soil property estimates (bulk density, organic carbon, clay, sand, silt, pH) at a given location, at multiple depth intervals.
- **AgroDataCube (Netherlands)** — Integrates with the WUR AgroDataCube v2 API for Dutch agricultural field parcels, crop history, and soil/crop KPIs. Maintains session memory of the last looked-up field for follow-up questions.
- **Vocabulary Lookup** — Queries the SoilWise SPARQL endpoint to retrieve SKOS concept hierarchies (broader, narrower, related, exact match terms with definitions) for soil science terminology.
- **Wikipedia** — Searches and retrieves Wikipedia articles in multiple languages (English, Dutch, French, Spanish, Italian, Czech) for general concepts and background information.
- **Auto-Linking** — Automatically links soil vocabulary terms and Wikipedia articles appearing in responses, making terms navigable to the SoilWise vocabulary browser and Wikipedia.
- **Insight Panel** — A sidebar panel that extracts SoilWise and Wikipedia links from the latest response and displays related vocabulary concepts with definitions, organized by broader/narrower/related relationships. Clickable vocabulary chips allow quick exploration of connected topics.
- **Location Context** — An interactive Leaflet map in the sidebar allows users to set a geographic context (with country search autocomplete), which is then used by location-aware tools.
- **File Upload** — Users can upload text or Markdown files (max 200 KB) as temporary context for the conversation.
- **RAG (Retrieval-Augmented Generation)** — Local core SoilWise knowledge documents (PDF, text, Markdown) are embedded on startup and used as supplementary context for answers, retrieved by semantic similarity.
- **Real-Time Streaming** — Responses are streamed token-by-token over WebSocket for low-latency feedback.
- **Feedback Collection** — Thumbs up/down feedback per response, logged in daily JSONL files for quality analysis. Evaluation tools can merge logs with feedback and compute quality metrics.
- **Initial Question via URL** — An initial question can be passed as a URL parameter, enabling deep-linking into the chatbot with a pre-filled query.
- **Health Endpoints** — Kubernetes-compatible liveness (`/healthz`) and readiness (`/readyz`) probes, including version and uptime reporting.
- **Auto-Update Detection** — The frontend polls the health endpoint to detect server version changes and notifies the user when an update is available.

### Non-functional Requirements

| Aspect | Constraint |
|--------|-----------|
| **Chat memory** | 50 messages per session (configurable) |
| **Max sequential tool calls** | 10 per query (configurable) |
| **Max LLM retries** | 3 (configurable) |
| **Session idle timeout** | 10 minutes (configurable) |
| **Max prompt size** | 120,000 characters (safety limit) |
| **Max upload size** | 200,000 characters |
| **RAG chunk size** | 500 characters with 100-character overlap |
| **RAG retrieval** | Top 5 results, minimum similarity score 0.6 |
| **Catalog search results** | Max 10 per query |
| **External API timeout** | 15,000 ms (Solr, SoilGrids, AgroDataCube, Wikipedia) |
| **SPARQL timeout** | 5,000 ms connection + 10,000 ms read |
| **WebSocket heartbeat** | Every 15 seconds |
| **Log retention** | 30 days (daily rotation, gzip compressed) |
| **HTML sanitization** | DOMPurify on all rendered markdown output |
| **Link safety** | All external links open with `noopener noreferrer` |
| **Accessibility** | ARIA labels, roles, live regions; keyboard navigation |

## Architecture

### Technological Stack

**Backend (JVM)**

| Component | Technology |
|-----------|-----------|
| **Language** | Scala 3.8.1 on JDK 17+ (tested 17–25) |
| **Build** | SBT 1.11.x / 1.12.x (cross-build JS/JVM) |
| **LLM Framework** | LangChain4j 1.10.x (OpenAI integration, agentic tool calling, embeddings, RAG) |
| **LLM Provider** | OpenAI (gpt-4o-mini for chat, gpt-4o for reasoning, text-embedding-3-small for embeddings) |
| **Local Embeddings** | AllMiniLmL6V2 (offline, ~33 MB model for RAG document retrieval) |
| **Vector Store** | In-memory embedding store (with experimental Chroma support) |
| **Logging** | SLF4J 3.0.x + Logback 1.5.x (daily rotation, 30-day retention) |
| **Document Parsing** | Apache Tika (PDF, text, Markdown) |

**Frontend (Browser)**

| Component | Technology |
|-----------|-----------|
| **Language** | Scala.js (compiled to JavaScript) |
| **Sanitization** | DOMPurify 3.x |
| **Maps** | Leaflet 1.9.x |
| **Communication** | WebSocket (real-time streaming) |

**Infrastructure**

| Component | Technology |
|-----------|-----------|
| **Container** | Docker (multi-stage build, Eclipse Temurin JDK 21) |
| **CI/CD** | GitLab CI with semantic release (conventional commits) |
| **Orchestration** | Kubernetes (liveness/readiness probes) |


### Overview of Key Features

The chatbot combines **agentic LLM tool calling** with **retrieval-augmented generation** and **post-response enrichment** to deliver grounded, linked answers. The key features are:

1. **Agentic tool calling** — The LLM autonomously decides which of the available tool integrations to invoke (catalog search, SoilGrids, AgroDataCube, Wikipedia, vocabulary SPARQL), executing up to 10 sequential tool-call iterations per query.
2. **RAG from local core knowledge** — Documents (PDF, text, Markdown) are split into chunks, embedded with a local model (AllMiniLmL6V2), and stored in memory. Relevant chunks are retrieved by cosine similarity and injected into the prompt.
3. **Response enrichment** — After the LLM generates a response, auto-linkers scan for vocabulary terms and Wikipedia article titles, inserting navigable links into the rendered output.
4. **Insight panel** — The frontend extracts SoilWise and Wikipedia links from responses and displays broader/narrower/related vocabulary concepts with definitions in a sidebar panel.
5. **Token streaming** — Responses are streamed token-by-token over WebSocket, giving users immediate visual feedback.
6. **Feedback loop** — Thumbs up/down ratings are logged to daily JSONL files; evaluation tools compute quality metrics (like rate, NSAT, Wilson lower bound).

### Component Diagrams

**High-level component overview:**

```
┌─────────────────────────────────────────────────────────────────────┐
│                        Browser (Scala.js)                           │
│  ┌───────────────────────────────────────────────────────────────┐  │
│  │  SoilCompanionApp                                             │  │
│  │  - WebSocket client (real-time chat streaming)                │  │
│  │  - Authentication & session management                        │  │
│  │  - Location picker (Leaflet map)                              │  │
│  │  - Insight panel (vocabulary concepts, Wikipedia links)       │  │
│  │  - File upload, feedback, theme toggle                        │  │
│  └───────────────────────────────────────────────────────────────┘  │
└──────────────────────────────┬──────────────────────────────────────┘
                               │ WebSocket + HTTP
┌──────────────────────────────▼──────────────────────────────────────┐
│                   SoilCompanionServer (Cask, JVM)                   │
│                                                                     │
│   Routes: /healthz, /readyz, /login, /logout, /session,             │
│           /subscribe/:id (WS), /query, /clear, /upload,             │
│           /feedback, /location, /vocab, /app/*                      │
│                                                                     │
│  ┌──────────────┐  ┌──────────────┐  ┌───────────────────────────┐  │
│  │   Config     │  │  Feedback    │  │   Session Management      │  │
│  │ (PureConfig) │  │  Logger      │  │   (ConcurrentHashMaps)    │  │
│  └──────────────┘  └──────────────┘  └───────────────────────────┘  │
│                                                                     │
│  ┌──────────────────────────────────────────────────────────────┐   │
│  │  Assistant (per session)                                     │   │
│  │  ┌────────────────────────────────────────────────────────┐  │   │
│  │  │  LangChain4j AiServices                                │  │   │
│  │  │  - StreamingChatModel (OpenAI)                         │  │   │
│  │  │  - ChatMemory (50 messages)                            │  │   │
│  │  │  - RAG ContentRetriever (embeddings + local docs)      │  │   │
│  │  │  - Tool methods (5 integrations)                       │  │   │
│  │  └────────────────────────────────────────────────────────┘  │   │
│  └──────────────────────────────────────────────────────────────┘   │
│                                                                     │
│  ┌───────────────┐  ┌────────────────┐                              │
│  │  VocabLinker  │  │WikipediaLinker │   (post-response linking)    │
│  └───────────────┘  └────────────────┘                              │
└──────────────────────────────┬──────────────────────────────────────┘
                               │ HTTP calls
┌──────────────────────────────▼──────────────────────────────────────┐
│                       External Services                             │
│                                                                     │
│  ┌──────────────┐ ┌──────────────┐ ┌────────────────────────────┐   │
│  │ OpenAI API   │ │  Solr        │ │  ISRIC SoilGrids v2.0      │   │
│  │ (LLM, embed) │ │  (catalog)   │ │  (global soil properties)  │   │
│  └──────────────┘ └──────────────┘ └────────────────────────────┘   │
│  ┌──────────────┐ ┌──────────────┐ ┌────────────────────────────┐   │
│  │  SoilWise    │ │  Wikipedia   │ │  WUR AgroDataCube v2       │   │
│  │  SPARQL      │ │  (6 langs)   │ │  (NL field data)           │   │
│  └──────────────┘ └──────────────┘ └────────────────────────────┘   │
└─────────────────────────────────────────────────────────────────────┘
```

### Sequence Diagram

**User query to response flow:**

```
  Client (Browser)                    Server (JVM)                      External APIs
  ─────────────────                   ────────────                      ──────────────
        │                                  │                                  │
        │──── GET /session ───────────────▶│                                  │
        │◀─── { sessionId: UUID } ─────────│                                  │
        │                                  │                                  │
        │──── WS /subscribe/:sessionId ───▶│  (store connection)              │
        │◀─── connection established ──────│                                  │
        │                                  │                                  │
        │──── POST /login ────────────────▶│  (validate credentials)          │
        │◀─── { ok: true } ────────────────│                                  │
        │                                  │                                  │
        │──── POST /query ────────────────▶│                                  │
        │     { sessionId, content }       │                                  │
        │                                  │                                  │
        │◀─── QueryEvent("received") ──────│  (generate questionId)           │
        │◀─── QueryEvent("thinking") ──────│                                  │
        │◀─── QueryEvent("retrieving_      │                                  │
        │      context") ──────────────────│                                  │
        │                                  │──── RAG: embed query ───────────▶│
        │                                  │◀─── top-5 document chunks ───────│
        │                                  │                                  │
        │                                  │──── LLM: evaluate tools ────────▶│ OpenAI
        │                                  │◀─── tool call decision ──────────│
        │                                  │                                  │
        │                                  │──── Tool: e.g. Solr search ─────▶│ Solr
        │                                  │◀─── search results ──────────────│
        │                                  │                                  │
        │                                  │──── LLM: synthesize answer ─────▶│ OpenAI
        │                                  │◀─── token stream begins ─────────│
        │                                  │                                  │
        │◀─ QueryPartialResponse(token) ───│  (repeated per token)            │
        │◀─ QueryPartialResponse(token) ───│                                  │
        │◀─ ...                            │                                  │
        │                                  │                                  │
        │                                  │  (stream complete)               │
        │                                  │  Apply VocabLinker               │
        │                                  │  Apply WikipediaLinker           │
        │                                  │                                  │
        │◀─ QueryEvent("links_added",      │                                  │
        │    linkedResponse) ──────────────│                                  │
        │◀─ QueryEvent("done") ────────────│                                  │
        │                                  │                                  │
        │  (render markdown, show          │                                  │
        │   feedback buttons)              │                                  │
        │                                  │                                  │
        │──── POST /feedback ─────────────▶│  (log to JSONL)                  │
        │     { questionId, vote }         │                                  │
```

**WebSocket event types:**

| Event | Direction | Purpose |
|-------|-----------|---------|
| `received` | Server → Client | Query acknowledged, questionId assigned |
| `thinking` | Server → Client | LLM is analysing the question |
| `retrieving_context` | Server → Client | RAG retrieval in progress |
| `generating` | Server → Client | LLM is generating the answer |
| `links_added` | Server → Client | Auto-linked response replacing the streamed version |
| `done` | Server → Client | Response complete |
| `error` | Server → Client | An error occurred |
| `heartbeat` | Server → Client | Keep-alive (every 15 seconds) |
| `session_expired` | Server → Client | Session timed out due to inactivity |
| `prompt_truncated` | Server → Client | Input was truncated to stay within limits |
| `QueryPartialResponse` | Server → Client | Single streamed token |

### Database Design

The Soil Companion does not use a traditional database. All runtime state is held in-memory; only feedback and application logs are persisted to disk.

**In-memory state (per server process):**

| Store | Type | Purpose |
|-------|------|---------|
| `wsConnections` | `ConcurrentHashMap[String, WsChannelActor]` | Active WebSocket connections |
| `assistants` | `ConcurrentHashMap[String, Assistant]` | LLM chat state per session |
| `uploadedTexts` | `ConcurrentHashMap[String, String]` | Temporary uploaded file content |
| `uploadedFilenames` | `ConcurrentHashMap[String, String]` | Original filenames of uploads |
| `locationContexts` | `ConcurrentHashMap[String, String]` | Location JSON per session |
| `authenticatedSessions` | `ConcurrentHashMap[String, Boolean]` | Authentication status |
| `lastActivity` | `ConcurrentHashMap[String, Long]` | Session inactivity tracking |

**In-memory vector store:**

| Store | Type | Purpose |
|-------|------|---------|
| `embeddingStore` | `InMemoryEmbeddingStore[TextSegment]` | Embedded knowledge document chunks |

Documents from the `data/knowledge/` directory are loaded, split into 500-character chunks (100-character overlap), embedded using AllMiniLmL6V2, and stored at startup.

**Persistent file storage:**

| Data | Location | Format |
|------|----------|--------|
| Feedback | `data/feedback-logs/feedback-YYYY-MM-DD.jsonl` | Daily JSONL, auto-rotated, gzip compressed |
| Application logs | `data/logs/soil-companion.log` | Logback rolling file (30-day retention, gzip) |
| Knowledge documents | `data/knowledge/` | PDF, text, Markdown (read-only at startup) |
| Vocabulary | `data/vocab/soilvoc_concepts_*.csv` | CSV (loaded at startup for auto-linking) |

**Shared domain models (Scala, cross-compiled for JVM and JS):**

- `QueryRequest(sessionId: String, content: String)` — client-to-server query message
- `QueryPartialResponse(content: String)` — streamed token from server
- `QueryEvent(event: String, detail: Option[String], questionId: Option[String])` — lifecycle event

### Integrations & Interfaces

| Service | Auth | Endpoint | Purpose |
|---------|------|----------|---------|
| **OpenAI API** | Bearer token (`OPENAI_API_KEY`) | via LangChain4j | Chat completion (gpt-4o-mini), reasoning (gpt-4o), embeddings (text-embedding-3-small) |
| **Solr (SoilWise Catalog)** | Basic Auth (`SOLR_USERNAME` / `SOLR_PASSWORD`) | `SOLR_BASE_URL` | Search datasets and publications; full-text content retrieval |
| **ISRIC SoilGrids v2.0** | None (public) | `SOILGRIDS_BASE_URL` | Soil property estimates at lat/lon (~250 m resolution) |
| **SoilWise SPARQL** | None | `VOCAB_SPARQL_ENDPOINT` | SKOS concept hierarchies (broader, narrower, related terms) |
| **Wikipedia** | None (public) | `WIKIPEDIA_BASE_URL` (per language) | Article search and content retrieval (6 languages) |
| **WUR AgroDataCube v2** | Token header (`AGRODATACUBE_ACCESS_TOKEN`) | `AGRODATACUBE_BASE_URL` | NL field parcels, crop history, soil/crop KPIs |

All external service credentials and endpoints are configured through HOCON (`application.conf`) with environment variable overrides.

**HTTP endpoints exposed by the server:**

| Method | Path | Purpose |
|--------|------|---------|
| `GET` | `/healthz` | Liveness probe (version, uptime) |
| `GET` | `/readyz` | Readiness probe (config + API key checks) |
| `POST` | `/login` | Demo authentication |
| `POST` | `/logout` | Session teardown |
| `GET` | `/session` | New session ID |
| `WS` | `/subscribe/:sessionId` | WebSocket for streaming chat |
| `POST` | `/query` | Submit a question |
| `POST` | `/clear` | Clear chat history |
| `POST` | `/upload` | Upload text/Markdown context |
| `POST` | `/feedback` | Submit thumbs up/down |
| `POST` | `/location` | Set geographic context |
| `POST` | `/vocab` | Batch vocabulary concept lookup |
| `GET` | `/app/*` | Static frontend assets |

### Key Architectural Decisions

| Decision | Rationale |
|----------|-----------|
| **Scala 3 + Scala.js cross-build** | Enables shared domain models (`QueryRequest`, `QueryEvent`, `QueryPartialResponse`) between backend and frontend, eliminating serialization mismatches and reducing code duplication. |
| **Cask HTTP micro-framework** | Lightweight, Scala-native server with built-in WebSocket support. Suitable for a single-service chatbot without the overhead of a full application framework. |
| **LangChain4j for LLM integration** | Provides a mature JVM-native abstraction for tool calling, RAG, streaming, and chat memory — avoiding the need to call OpenAI APIs directly. The `@Tool` annotation enables declarative tool registration. |
| **In-memory embedding store** | Simplifies deployment (no external vector database required). Sufficient for the current knowledge base (~5 documents). Trade-off: state is lost on restart and capacity is limited by server memory. |
| **AllMiniLmL6V2 for local embeddings** | Runs offline without API calls, keeping RAG retrieval fast and cost-free. The ~33 MB model is small enough to bundle in the Docker image. |
| **Per-session Assistant instances** | Each session gets its own `Assistant` with isolated chat memory, tool state (e.g. AgroDataCube field context), and uploaded file context. Prevents cross-session contamination. |
| **Post-response auto-linking** | VocabLinker and WikipediaLinker run after the LLM completes, replacing the streamed response with an enriched version. This avoids asking the LLM to generate links (which is unreliable) while still providing navigable references. |
| **WebSocket token streaming** | Provides immediate visual feedback during LLM generation, reducing perceived latency. A 15-second heartbeat prevents proxy/ingress idle timeouts. |
| **Environment variable configuration** | All credentials and endpoints are overridable via environment variables, following 12-factor app principles for containerized deployment. |
| **Demo authentication** | A simple single-user mode enables local development and demonstrations without requiring an external identity provider. Production deployment would integrate with an external auth layer. |

## Risks & Limitations

| Risk / Limitation | Description | Mitigation |
|-------------------|-------------|------------|
| **SoilGrids accuracy** | Returned values are modelled estimates at ~250 m grid resolution, not field measurements. | Tool responses include explicit disclaimers advising users to verify with local data. |
| **Single-user demo auth** | The demo authentication mode uses a single configurable account with no roles or authorization. Not suitable for production multi-user scenarios. | Designed for development/testing; production deployment requires integration with an external authentication and authorization layer. |
| **In-memory state loss** | All session state, chat memory, uploaded context, and the embedding store are lost on server restart. | Acceptable for a demo/chatbot use case. Persistent vector store (Chroma) support exists experimentally for future use. |
| **No horizontal scaling** | All sessions are held in a single JVM process with no shared session store. | Sufficient for current usage levels. Horizontal scaling would require an external session store and load balancer. |
| **External API availability** | The chatbot depends on multiple external APIs (Solr, SoilGrids, AgroDataCube, OpenAgroKPI, Wikipedia). Downtime or rate limits on any service degrades functionality. | Tool methods handle errors gracefully, returning informative messages. The LLM can fall back to other tools if one fails. LangChain4j provides configurable retry logic (max 3 retries). |
| **Geographic coverage** | AgroDataCube and OpenAgroKPI are Netherlands-only. SoilGrids is global but at coarse resolution. | Tool descriptions inform the LLM of geographic scope so it can communicate limitations to users. |
| **Knowledge base is static** | Local documents are loaded and embedded only at startup. No hot-reload mechanism exists. | A server restart picks up new documents. This is acceptable for infrequently changing knowledge resources. |
| **LLM hallucination** | Despite RAG grounding and tool results, the LLM may still generate inaccurate statements. | System prompts instruct the model to include disclaimers and prefer tool-grounded answers. User feedback collection enables ongoing quality monitoring. |
| **Prompt injection via uploads** | Uploaded files and location contexts could contain adversarial content. | Input sanitization is applied; prompt size is capped at 120,000 characters; file uploads are limited to 200 KB. |
| **CORS policy** | The file upload endpoint uses a permissive `Access-Control-Allow-Origin: *` header. | Acceptable for demo deployment; should be tightened for production. |
