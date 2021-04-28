---
title: CockroachDB v2 API v2.0.0
language_tabs:
  - shell: curl
language_clients:
  - shell: ""
toc_footers: []
includes: []
search: true
highlight_theme: darkula
headingLevel: 2

---

<!-- Generator: Widdershins v4.0.1 -->

<h1 id="cockroachdb-v2-api">CockroachDB v2 API v2.0.0</h1>

> Scroll down for code samples, example requests and responses. Select a language for code samples from the tabs above or the mobile navigation menu.

API for querying information about CockroachDB health, nodes, ranges,
sessions, and other meta entities.

Base URLs:

* <a href="http://localhost/api/v2/">http://localhost/api/v2/</a>

* <a href="https://localhost/api/v2/">https://localhost/api/v2/</a>

 License: Business Source License

# Authentication

* API Key (api_session)
    - Parameter Name: **X-Cockroach-API-Session**, in: header. Handle to logged-in REST session. Use `/login/` to log in and get a session.

<h1 id="cockroachdb-v2-api-default">Default</h1>

## Check node health

<a id="opIdhealth"></a>

> Code samples

```shell
# You can also use wget
curl -X GET http://localhost/api/v2/health/

```

`GET /health/`

Helper endpoint to check for node health. If `ready` is true, it also checks
if this node is fully operational and ready to accept SQL connections.
Otherwise, this endpoint always returns a successful response (if the API
server is up, of course).

<h3 id="check-node-health-parameters">Parameters</h3>

|Name|In|Type|Required|Description|
|---|---|---|---|---|
|ready|query|boolean|false|If true, check whether this node is ready to accept SQL connections. If false, this endpoint always returns success, unless the API server itself is down.|

<h3 id="check-node-health-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|Indicates healthy node.|None|
|500|[Internal Server Error](https://tools.ietf.org/html/rfc7231#section-6.6.1)|Indicates unhealthy node.|None|

<aside class="success">
This operation does not require authentication
</aside>

## API Login

<a id="opIdlogin"></a>

> Code samples

```shell
# You can also use wget
curl -X POST http://localhost/api/v2/login/ \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -H 'Accept: application/json'

```

`POST /login/`

Creates an API session for use with API endpoints that require
authentication.

> Body parameter

```yaml
password: string
username: string

```

<h3 id="api-login-parameters">Parameters</h3>

|Name|In|Type|Required|Description|
|---|---|---|---|---|
|body|body|object|true|Credentials for login|
|» password|body|string|true|none|
|» username|body|string|true|none|

> Example responses

> 200 Response

```json
{
  "session": "string"
}
```

```
{"session":"string"}
```

<h3 id="api-login-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|Login response.|[loginResponse](#schemaloginresponse)|
|400|[Bad Request](https://tools.ietf.org/html/rfc7231#section-6.5.1)|Bad request, if required parameters absent.|None|
|401|[Unauthorized](https://tools.ietf.org/html/rfc7235#section-3.1)|Unauthorized, if credentials don't match.|None|

<aside class="success">
This operation does not require authentication
</aside>

## API Logout

<a id="opIdlogout"></a>

> Code samples

```shell
# You can also use wget
curl -X POST http://localhost/api/v2/logout/ \
  -H 'Accept: application/json' \
  -H 'X-Cockroach-API-Session: API_KEY'

```

`POST /logout/`

Logs out on a previously-created API session.

> Example responses

> 200 Response

```json
{
  "logged_out": true
}
```

```
{"logged_out":true}
```

<h3 id="api-logout-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|Logout response.|[logoutResponse](#schemalogoutresponse)|
|400|[Bad Request](https://tools.ietf.org/html/rfc7231#section-6.5.1)|Bad request, if API session not present in headers, or invalid session.|None|

<aside class="warning">
To perform this operation, you must be authenticated by means of one of the following methods:
api_session
</aside>

## List nodes

<a id="opIdlistNodes"></a>

> Code samples

```shell
# You can also use wget
curl -X GET http://localhost/api/v2/nodes/ \
  -H 'Accept: application/json' \
  -H 'X-Cockroach-API-Session: API_KEY'

```

`GET /nodes/`

List all nodes on this cluster.

Client must be logged-in as a user with admin privileges.

<h3 id="list-nodes-parameters">Parameters</h3>

|Name|In|Type|Required|Description|
|---|---|---|---|---|
|limit|query|integer|false|Maximum number of results to return in this call.|
|offset|query|integer|false|Continuation token for results after a past limited run.|

> Example responses

> 200 Response

```json
{
  "next": 0,
  "nodes": [
    {
      "ServerVersion": {
        "internal": 0,
        "major_val": 0,
        "minor_val": 0,
        "patch": 0
      },
      "address": {
        "address_field": "string",
        "network_field": "string"
      },
      "attrs": {
        "attrs": [
          "string"
        ]
      },
      "build_tag": "string",
      "cluster_name": "string",
      "liveness_status": 0,
      "locality": {
        "tiers": [
          {
            "key": "string",
            "value": "string"
          }
        ]
      },
      "metrics": {
        "property1": 0,
        "property2": 0
      },
      "node_id": 0,
      "num_cpus": 0,
      "sql_address": {
        "address_field": "string",
        "network_field": "string"
      },
      "started_at": 0,
      "total_system_memory": 0,
      "updated_at": 0
    }
  ]
}
```

<h3 id="list-nodes-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|List nodes response.|[nodesResponse](#schemanodesresponse)|

<aside class="warning">
To perform this operation, you must be authenticated by means of one of the following methods:
api_session
</aside>

## List ranges on a node

<a id="opIdlistNodeRanges"></a>

> Code samples

```shell
# You can also use wget
curl -X GET http://localhost/api/v2/nodes/{node_id}/ranges/ \
  -H 'Accept: application/json' \
  -H 'X-Cockroach-API-Session: API_KEY'

```

`GET /nodes/{node_id}/ranges/`

Lists information about ranges on a specified node. If a list of range IDs
is specified, only information about those ranges is returned.

Client must be logged-in as a user with admin privileges.

<h3 id="list-ranges-on-a-node-parameters">Parameters</h3>

|Name|In|Type|Required|Description|
|---|---|---|---|---|
|node_id|path|integer|true|ID of node to query, or `local` for local node.|
|ranges|query|array[integer]|false|IDs of ranges to return information for. All ranges returned if unspecified.|
|limit|query|integer|false|Maximum number of results to return in this call.|
|offset|query|integer|false|Continuation token for results after a past limited run.|

> Example responses

> 200 Response

```json
{
  "next": 0,
  "ranges": [
    {
      "desc": {
        "end_key": [
          0
        ],
        "queries_per_second": 0,
        "range_id": 0,
        "start_key": [
          0
        ],
        "store_id": 0
      },
      "error_message": "string",
      "lease_history": [
        {
          "deprecated_start_stasis": {
            "logical": 0,
            "synthetic": true,
            "wall_time": 0
          },
          "epoch": 0,
          "expiration": {
            "logical": 0,
            "synthetic": true,
            "wall_time": 0
          },
          "proposed_ts": {
            "logical": 0,
            "synthetic": true,
            "wall_time": 0
          },
          "replica": {
            "node_id": 0,
            "replica_id": 0,
            "store_id": 0,
            "type": 0
          },
          "sequence": 0,
          "start": {
            "logical": 0,
            "synthetic": true,
            "wall_time": 0
          }
        }
      ],
      "problems": {
        "leader_not_lease_holder": true,
        "no_lease": true,
        "no_raft_leader": true,
        "overreplicated": true,
        "quiescent_equals_ticking": true,
        "raft_log_too_large": true,
        "unavailable": true,
        "underreplicated": true
      },
      "quiescent": true,
      "source_node_id": 0,
      "source_store_id": 0,
      "span": {
        "end_key": "string",
        "start_key": "string"
      },
      "stats": {
        "queries_per_second": 0,
        "writes_per_second": 0
      },
      "ticking": true
    }
  ]
}
```

<h3 id="list-ranges-on-a-node-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|Node ranges response.|[nodeRangesResponse](#schemanoderangesresponse)|

<aside class="warning">
To perform this operation, you must be authenticated by means of one of the following methods:
api_session
</aside>

## List hot ranges

<a id="opIdlistHotRanges"></a>

> Code samples

```shell
# You can also use wget
curl -X GET http://localhost/api/v2/ranges/hot/ \
  -H 'Accept: application/json' \
  -H 'X-Cockroach-API-Session: API_KEY'

```

`GET /ranges/hot/`

Lists information about hot ranges. If a list of range IDs
is specified, only information about those ranges is returned.

Client must be logged-in as a user with admin privileges.

<h3 id="list-hot-ranges-parameters">Parameters</h3>

|Name|In|Type|Required|Description|
|---|---|---|---|---|
|node_id|query|integer|false|ID of node to query, or `local` for local node. If unspecified, all nodes are queried.|
|limit|query|integer|false|Maximum number of results to return in this call.|
|start|query|string|false|Continuation token for results after a past limited run.|

> Example responses

> 200 Response

```json
{
  "next": "string",
  "ranges_by_node_id": {
    "property1": [
      {
        "end_key": [
          0
        ],
        "queries_per_second": 0,
        "range_id": 0,
        "start_key": [
          0
        ],
        "store_id": 0
      }
    ],
    "property2": [
      {
        "end_key": [
          0
        ],
        "queries_per_second": 0,
        "range_id": 0,
        "start_key": [
          0
        ],
        "store_id": 0
      }
    ]
  },
  "response_error": [
    {
      "error_message": "string",
      "node_id": 0
    }
  ]
}
```

<h3 id="list-hot-ranges-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|Hot ranges response.|[hotRangesResponse](#schemahotrangesresponse)|

<aside class="warning">
To perform this operation, you must be authenticated by means of one of the following methods:
api_session
</aside>

## Get info about a range

<a id="opIdlistRange"></a>

> Code samples

```shell
# You can also use wget
curl -X GET http://localhost/api/v2/ranges/{range_id}/ \
  -H 'Accept: application/json' \
  -H 'X-Cockroach-API-Session: API_KEY'

```

`GET /ranges/{range_id}/`

Retrieves more information about a specific range.

Client must be logged-in as a user with admin privileges.

<h3 id="get-info-about-a-range-parameters">Parameters</h3>

|Name|In|Type|Required|Description|
|---|---|---|---|---|
|range_id|path|integer|true|none|

> Example responses

> 200 Response

```json
{
  "responses_by_node_id": {
    "property1": {
      "error": "string",
      "range_info": {
        "desc": {
          "end_key": [
            0
          ],
          "queries_per_second": 0,
          "range_id": 0,
          "start_key": [
            0
          ],
          "store_id": 0
        },
        "error_message": "string",
        "lease_history": [
          {
            "deprecated_start_stasis": {
              "logical": 0,
              "synthetic": true,
              "wall_time": 0
            },
            "epoch": 0,
            "expiration": {
              "logical": 0,
              "synthetic": true,
              "wall_time": 0
            },
            "proposed_ts": {
              "logical": 0,
              "synthetic": true,
              "wall_time": 0
            },
            "replica": {
              "node_id": 0,
              "replica_id": 0,
              "store_id": 0,
              "type": 0
            },
            "sequence": 0,
            "start": {
              "logical": 0,
              "synthetic": true,
              "wall_time": 0
            }
          }
        ],
        "problems": {
          "leader_not_lease_holder": true,
          "no_lease": true,
          "no_raft_leader": true,
          "overreplicated": true,
          "quiescent_equals_ticking": true,
          "raft_log_too_large": true,
          "unavailable": true,
          "underreplicated": true
        },
        "quiescent": true,
        "source_node_id": 0,
        "source_store_id": 0,
        "span": {
          "end_key": "string",
          "start_key": "string"
        },
        "stats": {
          "queries_per_second": 0,
          "writes_per_second": 0
        },
        "ticking": true
      }
    },
    "property2": {
      "error": "string",
      "range_info": {
        "desc": {
          "end_key": [
            0
          ],
          "queries_per_second": 0,
          "range_id": 0,
          "start_key": [
            0
          ],
          "store_id": 0
        },
        "error_message": "string",
        "lease_history": [
          {
            "deprecated_start_stasis": {
              "logical": 0,
              "synthetic": true,
              "wall_time": 0
            },
            "epoch": 0,
            "expiration": {
              "logical": 0,
              "synthetic": true,
              "wall_time": 0
            },
            "proposed_ts": {
              "logical": 0,
              "synthetic": true,
              "wall_time": 0
            },
            "replica": {
              "node_id": 0,
              "replica_id": 0,
              "store_id": 0,
              "type": 0
            },
            "sequence": 0,
            "start": {
              "logical": 0,
              "synthetic": true,
              "wall_time": 0
            }
          }
        ],
        "problems": {
          "leader_not_lease_holder": true,
          "no_lease": true,
          "no_raft_leader": true,
          "overreplicated": true,
          "quiescent_equals_ticking": true,
          "raft_log_too_large": true,
          "unavailable": true,
          "underreplicated": true
        },
        "quiescent": true,
        "source_node_id": 0,
        "source_store_id": 0,
        "span": {
          "end_key": "string",
          "start_key": "string"
        },
        "stats": {
          "queries_per_second": 0,
          "writes_per_second": 0
        },
        "ticking": true
      }
    }
  }
}
```

<h3 id="get-info-about-a-range-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|List range response|[rangeResponse](#schemarangeresponse)|

<aside class="warning">
To perform this operation, you must be authenticated by means of one of the following methods:
api_session
</aside>

## List sessions

<a id="opIdlistSessions"></a>

> Code samples

```shell
# You can also use wget
curl -X GET http://localhost/api/v2/sessions/ \
  -H 'Accept: application/json' \
  -H 'X-Cockroach-API-Session: API_KEY'

```

`GET /sessions/`

List all sessions on this cluster. If a username is provided, only
sessions from that user are returned.

Client must be logged-in as a user with admin privileges.

<h3 id="list-sessions-parameters">Parameters</h3>

|Name|In|Type|Required|Description|
|---|---|---|---|---|
|username|query|string|false|Username of user to return sessions for; if unspecified, sessions from all users are returned.|
|limit|query|integer|false|Maximum number of results to return in this call.|
|start|query|string|false|Continuation token for results after a past limited run.|

> Example responses

> 200 Response

```json
{
  "errors": [
    {
      "message": "string",
      "node_id": 0
    }
  ],
  "next": "string",
  "sessions": [
    {
      "active_queries": [
        {
          "id": "string",
          "is_distributed": true,
          "phase": 0,
          "progress": 0,
          "sql": "string",
          "sql_anon": "string",
          "start": "2019-08-24T14:15:22Z",
          "txn_id": [
            0
          ]
        }
      ],
      "active_txn": {
        "alloc_bytes": 0,
        "deadline": "2019-08-24T14:15:22Z",
        "id": [
          0
        ],
        "implicit": true,
        "is_historical": true,
        "max_alloc_bytes": 0,
        "num_auto_retries": 0,
        "num_retries": 0,
        "num_statements_executed": 0,
        "priority": "string",
        "read_only": true,
        "start": "2019-08-24T14:15:22Z",
        "txn_description": "string"
      },
      "alloc_bytes": 0,
      "application_name": "string",
      "client_address": "string",
      "id": [
        0
      ],
      "last_active_query": "string",
      "last_active_query_anon": "string",
      "max_alloc_bytes": 0,
      "node_id": 0,
      "start": "2019-08-24T14:15:22Z",
      "username": "string"
    }
  ]
}
```

<h3 id="list-sessions-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|List sessions response.|[listSessionsResp](#schemalistsessionsresp)|

<aside class="warning">
To perform this operation, you must be authenticated by means of one of the following methods:
api_session
</aside>

# Schemas

<h2 id="tocS_ActiveQuery">ActiveQuery</h2>
<!-- backwards compatibility -->
<a id="schemaactivequery"></a>
<a id="schema_ActiveQuery"></a>
<a id="tocSactivequery"></a>
<a id="tocsactivequery"></a>

```json
{
  "id": "string",
  "is_distributed": true,
  "phase": 0,
  "progress": 0,
  "sql": "string",
  "sql_anon": "string",
  "start": "2019-08-24T14:15:22Z",
  "txn_id": [
    0
  ]
}

```

ActiveQuery represents a query in flight on some Session.

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|id|string|false|none|ID of the query (uint128 presented as a hexadecimal string).|
|is_distributed|boolean|false|none|True if this query is distributed.|
|phase|[ActiveQuery_Phase](#schemaactivequery_phase)|false|none|none|
|progress|number(float)|false|none|none|
|sql|string|false|none|SQL query string specified by the user.|
|sql_anon|string|false|none|The SQL statement fingerprint, compatible with StatementStatisticsKey.|
|start|string(date-time)|false|none|Start timestamp of this query.|
|txn_id|[UUID](#schemauuid)|false|none|none|

<h2 id="tocS_ActiveQuery_Phase">ActiveQuery_Phase</h2>
<!-- backwards compatibility -->
<a id="schemaactivequery_phase"></a>
<a id="schema_ActiveQuery_Phase"></a>
<a id="tocSactivequery_phase"></a>
<a id="tocsactivequery_phase"></a>

```json
0

```

Enum for phase of execution.

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|Enum for phase of execution.|integer(int32)|false|none|none|

<h2 id="tocS_Attributes">Attributes</h2>
<!-- backwards compatibility -->
<a id="schemaattributes"></a>
<a id="schema_Attributes"></a>
<a id="tocSattributes"></a>
<a id="tocsattributes"></a>

```json
{
  "attrs": [
    "string"
  ]
}

```

Attributes specifies a list of arbitrary strings describing
node topology, store type, and machine capabilities.

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|attrs|[string]|false|none|none|

<h2 id="tocS_ClockTimestamp">ClockTimestamp</h2>
<!-- backwards compatibility -->
<a id="schemaclocktimestamp"></a>
<a id="schema_ClockTimestamp"></a>
<a id="tocSclocktimestamp"></a>
<a id="tocsclocktimestamp"></a>

```json
{
  "logical": 0,
  "synthetic": true,
  "wall_time": 0
}

```

### Properties

*None*

<h2 id="tocS_Key">Key</h2>
<!-- backwards compatibility -->
<a id="schemakey"></a>
<a id="schema_Key"></a>
<a id="tocSkey"></a>
<a id="tocskey"></a>

```json
[
  0
]

```

Key is a custom type for a byte string in proto
messages which refer to Cockroach keys.

### Properties

*None*

<h2 id="tocS_Lease">Lease</h2>
<!-- backwards compatibility -->
<a id="schemalease"></a>
<a id="schema_Lease"></a>
<a id="tocSlease"></a>
<a id="tocslease"></a>

```json
{
  "deprecated_start_stasis": {
    "logical": 0,
    "synthetic": true,
    "wall_time": 0
  },
  "epoch": 0,
  "expiration": {
    "logical": 0,
    "synthetic": true,
    "wall_time": 0
  },
  "proposed_ts": {
    "logical": 0,
    "synthetic": true,
    "wall_time": 0
  },
  "replica": {
    "node_id": 0,
    "replica_id": 0,
    "store_id": 0,
    "type": 0
  },
  "sequence": 0,
  "start": {
    "logical": 0,
    "synthetic": true,
    "wall_time": 0
  }
}

```

Lease contains information about range leases including the
expiration and lease holder.

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|deprecated_start_stasis|[Timestamp](#schematimestamp)|false|none|none|
|epoch|integer(int64)|false|none|The epoch of the lease holder's node liveness entry. If this value is<br>non-zero, the expiration field is ignored.|
|expiration|[Timestamp](#schematimestamp)|false|none|none|
|proposed_ts|[ClockTimestamp](#schemaclocktimestamp)|false|none|none|
|replica|[ReplicaDescriptor](#schemareplicadescriptor)|false|none|ReplicaDescriptor describes a replica location by node ID<br>(corresponds to a host:port via lookup on gossip network) and store<br>ID (identifies the device).<br>TODO(jeffreyxiao): All nullable fields in ReplicaDescriptor can be made<br>non-nullable if #38302 is guaranteed to be on all nodes (I.E. 20.1).|
|sequence|[LeaseSequence](#schemaleasesequence)|false|none|none|
|start|[ClockTimestamp](#schemaclocktimestamp)|false|none|none|

<h2 id="tocS_LeaseSequence">LeaseSequence</h2>
<!-- backwards compatibility -->
<a id="schemaleasesequence"></a>
<a id="schema_LeaseSequence"></a>
<a id="tocSleasesequence"></a>
<a id="tocsleasesequence"></a>

```json
0

```

LeaseSequence is a custom type for a lease sequence number.

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|LeaseSequence is a custom type for a lease sequence number.|integer(int64)|false|none|none|

<h2 id="tocS_ListSessionsError">ListSessionsError</h2>
<!-- backwards compatibility -->
<a id="schemalistsessionserror"></a>
<a id="schema_ListSessionsError"></a>
<a id="tocSlistsessionserror"></a>
<a id="tocslistsessionserror"></a>

```json
{
  "message": "string",
  "node_id": 0
}

```

An error wrapper object for ListSessionsResponse.

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|message|string|false|none|Error message.|
|node_id|[NodeID](#schemanodeid)|false|none|NodeID is a custom type for a cockroach node ID. (not a raft node ID)<br>0 is not a valid NodeID.|

<h2 id="tocS_ListSessionsResponse">ListSessionsResponse</h2>
<!-- backwards compatibility -->
<a id="schemalistsessionsresponse"></a>
<a id="schema_ListSessionsResponse"></a>
<a id="tocSlistsessionsresponse"></a>
<a id="tocslistsessionsresponse"></a>

```json
{
  "errors": [
    {
      "message": "string",
      "node_id": 0
    }
  ],
  "sessions": [
    {
      "active_queries": [
        {
          "id": "string",
          "is_distributed": true,
          "phase": 0,
          "progress": 0,
          "sql": "string",
          "sql_anon": "string",
          "start": "2019-08-24T14:15:22Z",
          "txn_id": [
            0
          ]
        }
      ],
      "active_txn": {
        "alloc_bytes": 0,
        "deadline": "2019-08-24T14:15:22Z",
        "id": [
          0
        ],
        "implicit": true,
        "is_historical": true,
        "max_alloc_bytes": 0,
        "num_auto_retries": 0,
        "num_retries": 0,
        "num_statements_executed": 0,
        "priority": "string",
        "read_only": true,
        "start": "2019-08-24T14:15:22Z",
        "txn_description": "string"
      },
      "alloc_bytes": 0,
      "application_name": "string",
      "client_address": "string",
      "id": [
        0
      ],
      "last_active_query": "string",
      "last_active_query_anon": "string",
      "max_alloc_bytes": 0,
      "node_id": 0,
      "start": "2019-08-24T14:15:22Z",
      "username": "string"
    }
  ]
}

```

Response object for ListSessions and ListLocalSessions.

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|errors|[[ListSessionsError](#schemalistsessionserror)]|false|none|Any errors that occurred during fan-out calls to other nodes.|
|sessions|[[Session](#schemasession)]|false|none|A list of sessions on this node or cluster.|

<h2 id="tocS_Locality">Locality</h2>
<!-- backwards compatibility -->
<a id="schemalocality"></a>
<a id="schema_Locality"></a>
<a id="tocSlocality"></a>
<a id="tocslocality"></a>

```json
{
  "tiers": [
    {
      "key": "string",
      "value": "string"
    }
  ]
}

```

Locality is an ordered set of key value Tiers that describe a node's
location. The tier keys should be the same across all nodes.

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|tiers|[[Tier](#schematier)]|false|none|none|

<h2 id="tocS_NodeID">NodeID</h2>
<!-- backwards compatibility -->
<a id="schemanodeid"></a>
<a id="schema_NodeID"></a>
<a id="tocSnodeid"></a>
<a id="tocsnodeid"></a>

```json
0

```

NodeID is a custom type for a cockroach node ID. (not a raft node ID)
0 is not a valid NodeID.

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|*anonymous*|integer(int32)|false|none|NodeID is a custom type for a cockroach node ID. (not a raft node ID)<br>0 is not a valid NodeID.|

<h2 id="tocS_NodeLivenessStatus">NodeLivenessStatus</h2>
<!-- backwards compatibility -->
<a id="schemanodelivenessstatus"></a>
<a id="schema_NodeLivenessStatus"></a>
<a id="tocSnodelivenessstatus"></a>
<a id="tocsnodelivenessstatus"></a>

```json
0

```

NodeLivenessStatus describes the status of a node from the perspective of the
liveness system. See comment on LivenessStatus() for a description of the
states.

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|NodeLivenessStatus describes the status of a node from the perspective of the
liveness system. See comment on LivenessStatus() for a description of the
states.|integer(int32)|false|none|TODO(irfansharif): We should reconsider usage of NodeLivenessStatus.<br>It's unclear if the enum is well considered. It enumerates across two<br>distinct set of things: the "membership" status (live/active,<br>decommissioning, decommissioned), and the node "process" status (live,<br>unavailable, available). It's possible for two of these "states" to be true,<br>simultaneously (consider a decommissioned, dead node). It makes for confusing<br>semantics, and the code attempting to disambiguate across these states<br>(kvserver.LivenessStatus() for e.g.) seem wholly arbitrary.<br><br>See #50707 for more details.|

<h2 id="tocS_PrettySpan">PrettySpan</h2>
<!-- backwards compatibility -->
<a id="schemaprettyspan"></a>
<a id="schema_PrettySpan"></a>
<a id="tocSprettyspan"></a>
<a id="tocsprettyspan"></a>

```json
{
  "end_key": "string",
  "start_key": "string"
}

```

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|end_key|string|false|none|none|
|start_key|string|false|none|none|

<h2 id="tocS_RKey">RKey</h2>
<!-- backwards compatibility -->
<a id="schemarkey"></a>
<a id="schema_RKey"></a>
<a id="tocSrkey"></a>
<a id="tocsrkey"></a>

```json
[
  0
]

```

### Properties

*None*

<h2 id="tocS_RangeID">RangeID</h2>
<!-- backwards compatibility -->
<a id="schemarangeid"></a>
<a id="schema_RangeID"></a>
<a id="tocSrangeid"></a>
<a id="tocsrangeid"></a>

```json
0

```

A RangeID is a unique ID associated to a Raft consensus group.

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|A RangeID is a unique ID associated to a Raft consensus group.|integer(int64)|false|none|none|

<h2 id="tocS_RangeProblems">RangeProblems</h2>
<!-- backwards compatibility -->
<a id="schemarangeproblems"></a>
<a id="schema_RangeProblems"></a>
<a id="tocSrangeproblems"></a>
<a id="tocsrangeproblems"></a>

```json
{
  "leader_not_lease_holder": true,
  "no_lease": true,
  "no_raft_leader": true,
  "overreplicated": true,
  "quiescent_equals_ticking": true,
  "raft_log_too_large": true,
  "unavailable": true,
  "underreplicated": true
}

```

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|leader_not_lease_holder|boolean|false|none|none|
|no_lease|boolean|false|none|none|
|no_raft_leader|boolean|false|none|none|
|overreplicated|boolean|false|none|none|
|quiescent_equals_ticking|boolean|false|none|Quiescent ranges do not tick by definition, but we track this in<br>two different ways and suspect that they're getting out of sync.<br>If the replica's quiescent flag doesn't agree with the store's<br>list of replicas that are ticking, warn about it.|
|raft_log_too_large|boolean|false|none|When the raft log is too large, it can be a symptom of other issues.|
|unavailable|boolean|false|none|none|
|underreplicated|boolean|false|none|none|

<h2 id="tocS_RangeStatistics">RangeStatistics</h2>
<!-- backwards compatibility -->
<a id="schemarangestatistics"></a>
<a id="schema_RangeStatistics"></a>
<a id="tocSrangestatistics"></a>
<a id="tocsrangestatistics"></a>

```json
{
  "queries_per_second": 0,
  "writes_per_second": 0
}

```

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|queries_per_second|number(double)|false|none|Note that queries per second will only be known by the leaseholder.<br>All other replicas will report it as 0.|
|writes_per_second|number(double)|false|none|none|

<h2 id="tocS_ReplicaDescriptor">ReplicaDescriptor</h2>
<!-- backwards compatibility -->
<a id="schemareplicadescriptor"></a>
<a id="schema_ReplicaDescriptor"></a>
<a id="tocSreplicadescriptor"></a>
<a id="tocsreplicadescriptor"></a>

```json
{
  "node_id": 0,
  "replica_id": 0,
  "store_id": 0,
  "type": 0
}

```

ReplicaDescriptor describes a replica location by node ID
(corresponds to a host:port via lookup on gossip network) and store
ID (identifies the device).
TODO(jeffreyxiao): All nullable fields in ReplicaDescriptor can be made
non-nullable if #38302 is guaranteed to be on all nodes (I.E. 20.1).

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|node_id|[NodeID](#schemanodeid)|false|none|NodeID is a custom type for a cockroach node ID. (not a raft node ID)<br>0 is not a valid NodeID.|
|replica_id|[ReplicaID](#schemareplicaid)|false|none|none|
|store_id|[StoreID](#schemastoreid)|false|none|none|
|type|[ReplicaType](#schemareplicatype)|false|none|All VOTER* types indicate a replica that participates in all raft activities,<br>including voting for leadership and committing entries. Typically, this<br>requires a majority of voters to reach a decision. In a joint config, two<br>separate majorities are required: one from the set of replicas that have<br>either type VOTER or VOTER_OUTGOING or VOTER_DEMOTING_{LEARNER, NON_VOTER},<br>as well as that of the set of types VOTER and VOTER_INCOMING . For example,<br>when type VOTER_FULL is assigned to replicas 1 and 2, while 3 is<br>VOTER_OUTGOING and 4 is VOTER_INCOMING, then the two sets over which quorums<br>need to be achieved are {1,2,3} and {1,2,4}. Thus, {1,2} is a quorum of both,<br>{1,3} is a quorum of the first but not the second, {1,4} is a quorum of the<br>second but not the first, and {3,4} is a quorum of neither.|

<h2 id="tocS_ReplicaID">ReplicaID</h2>
<!-- backwards compatibility -->
<a id="schemareplicaid"></a>
<a id="schema_ReplicaID"></a>
<a id="tocSreplicaid"></a>
<a id="tocsreplicaid"></a>

```json
0

```

ReplicaID is a custom type for a range replica ID.

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|ReplicaID is a custom type for a range replica ID.|integer(int32)|false|none|none|

<h2 id="tocS_ReplicaType">ReplicaType</h2>
<!-- backwards compatibility -->
<a id="schemareplicatype"></a>
<a id="schema_ReplicaType"></a>
<a id="tocSreplicatype"></a>
<a id="tocsreplicatype"></a>

```json
0

```

ReplicaType identifies which raft activities a replica participates in. In
normal operation, VOTER_FULL, NON_VOTER, and LEARNER are the only used
states. However, atomic replication changes require a transition through a
"joint config"; in this joint config, the VOTER_DEMOTING_{LEARNER, NON_VOTER}
and VOTER_INCOMING types are used as well to denote voters which are being
downgraded to learners and newly added by the change, respectively. When
being removed, a demoting voter is turning into a learner, which we prefer
over a direct removal, which was used prior to v20.1 and uses the
VOTER_OUTGOING type instead (see VersionChangeReplicasDemotion for details on
why we're not doing that any more).

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|ReplicaType identifies which raft activities a replica participates in. In
normal operation, VOTER_FULL, NON_VOTER, and LEARNER are the only used
states. However, atomic replication changes require a transition through a
"joint config"; in this joint config, the VOTER_DEMOTING_{LEARNER, NON_VOTER}
and VOTER_INCOMING types are used as well to denote voters which are being
downgraded to learners and newly added by the change, respectively. When
being removed, a demoting voter is turning into a learner, which we prefer
over a direct removal, which was used prior to v20.1 and uses the
VOTER_OUTGOING type instead (see VersionChangeReplicasDemotion for details on
why we're not doing that any more).|integer(int32)|false|none|All VOTER* types indicate a replica that participates in all raft activities,<br>including voting for leadership and committing entries. Typically, this<br>requires a majority of voters to reach a decision. In a joint config, two<br>separate majorities are required: one from the set of replicas that have<br>either type VOTER or VOTER_OUTGOING or VOTER_DEMOTING_{LEARNER, NON_VOTER},<br>as well as that of the set of types VOTER and VOTER_INCOMING . For example,<br>when type VOTER_FULL is assigned to replicas 1 and 2, while 3 is<br>VOTER_OUTGOING and 4 is VOTER_INCOMING, then the two sets over which quorums<br>need to be achieved are {1,2,3} and {1,2,4}. Thus, {1,2} is a quorum of both,<br>{1,3} is a quorum of the first but not the second, {1,4} is a quorum of the<br>second but not the first, and {3,4} is a quorum of neither.|

<h2 id="tocS_Session">Session</h2>
<!-- backwards compatibility -->
<a id="schemasession"></a>
<a id="schema_Session"></a>
<a id="tocSsession"></a>
<a id="tocssession"></a>

```json
{
  "active_queries": [
    {
      "id": "string",
      "is_distributed": true,
      "phase": 0,
      "progress": 0,
      "sql": "string",
      "sql_anon": "string",
      "start": "2019-08-24T14:15:22Z",
      "txn_id": [
        0
      ]
    }
  ],
  "active_txn": {
    "alloc_bytes": 0,
    "deadline": "2019-08-24T14:15:22Z",
    "id": [
      0
    ],
    "implicit": true,
    "is_historical": true,
    "max_alloc_bytes": 0,
    "num_auto_retries": 0,
    "num_retries": 0,
    "num_statements_executed": 0,
    "priority": "string",
    "read_only": true,
    "start": "2019-08-24T14:15:22Z",
    "txn_description": "string"
  },
  "alloc_bytes": 0,
  "application_name": "string",
  "client_address": "string",
  "id": [
    0
  ],
  "last_active_query": "string",
  "last_active_query_anon": "string",
  "max_alloc_bytes": 0,
  "node_id": 0,
  "start": "2019-08-24T14:15:22Z",
  "username": "string"
}

```

Session represents one SQL session.

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|active_queries|[[ActiveQuery](#schemaactivequery)]|false|none|Queries in progress on this session.|
|active_txn|[TxnInfo](#schematxninfo)|false|none|none|
|alloc_bytes|integer(int64)|false|none|Number of currently allocated bytes in the session memory monitor.|
|application_name|string|false|none|Application name specified by the client.|
|client_address|string|false|none|Connected client's IP address and port.|
|id|[integer]|false|none|ID of the session (uint128 represented as raw bytes).|
|last_active_query|string|false|none|SQL string of the last query executed on this session.|
|last_active_query_anon|string|false|none|The SQL statement fingerprint of the last query executed on this session,<br>compatible with StatementStatisticsKey.|
|max_alloc_bytes|integer(int64)|false|none|High water mark of allocated bytes in the session memory monitor.|
|node_id|[NodeID](#schemanodeid)|false|none|NodeID is a custom type for a cockroach node ID. (not a raft node ID)<br>0 is not a valid NodeID.|
|start|string(date-time)|false|none|Timestamp of session's start.|
|username|string|false|none|Username of the user for this session.|

<h2 id="tocS_StoreID">StoreID</h2>
<!-- backwards compatibility -->
<a id="schemastoreid"></a>
<a id="schema_StoreID"></a>
<a id="tocSstoreid"></a>
<a id="tocsstoreid"></a>

```json
0

```

StoreID is a custom type for a cockroach store ID.

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|StoreID is a custom type for a cockroach store ID.|integer(int32)|false|none|none|

<h2 id="tocS_Tier">Tier</h2>
<!-- backwards compatibility -->
<a id="schematier"></a>
<a id="schema_Tier"></a>
<a id="tocStier"></a>
<a id="tocstier"></a>

```json
{
  "key": "string",
  "value": "string"
}

```

Tier represents one level of the locality hierarchy.

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|key|string|false|none|Key is the name of tier and should match all other nodes.|
|value|string|false|none|Value is node specific value corresponding to the key.|

<h2 id="tocS_Timestamp">Timestamp</h2>
<!-- backwards compatibility -->
<a id="schematimestamp"></a>
<a id="schema_Timestamp"></a>
<a id="tocStimestamp"></a>
<a id="tocstimestamp"></a>

```json
{
  "logical": 0,
  "synthetic": true,
  "wall_time": 0
}

```

Timestamp represents a state of the hybrid logical clock.

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|logical|integer(int32)|false|none|The logical component captures causality for events whose wall times<br>are equal. It is effectively bounded by (maximum clock skew)/(minimal<br>ns between events) and nearly impossible to overflow.<br><br>It is not safe to mutate this field directly. Instead, use one of the<br>methods on Timestamp, which ensure that the synthetic flag is updated<br>appropriately.|
|synthetic|boolean|false|none|Indicates that the Timestamp did not come from an HLC clock somewhere<br>in the system and, therefore, does not have the ability to update a<br>peer's HLC clock. If set to true, the "synthetic timestamp" may be<br>arbitrarily disconnected from real time.<br><br>The flag serves as the dynamically typed version of a ClockTimestamp<br>(but inverted). Only Timestamps with this flag set to false can be<br>downcast to a ClockTimestamp successfully (see TryToClockTimestamp).<br><br>Synthetic timestamps with this flag set to true are central to<br>non-blocking transactions, which write "into the future". Setting the<br>flag to true is also used to disconnect some committed MVCC versions<br>from observed timestamps by indicating that those versions were moved<br>from the timestamp at which they were originally written. Committed<br>MVCC versions with synthetic timestamps require observing the full<br>uncertainty interval, whereas readings off the leaseholders's clock<br>can tighten the uncertainty interval that is applied to MVCC versions<br>with clock timestamp.<br><br>This flag does not affect the sort order of Timestamps. However, it<br>is considered when performing structural equality checks (e.g. using<br>the == operator). Consider use of the EqOrdering method when testing<br>for equality.|
|wall_time|integer(int64)|false|none|Holds a wall time, typically a unix epoch time expressed in<br>nanoseconds.<br><br>It is not safe to mutate this field directly. Instead, use one of the<br>methods on Timestamp, which ensure that the synthetic flag is updated<br>appropriately.|

<h2 id="tocS_TxnInfo">TxnInfo</h2>
<!-- backwards compatibility -->
<a id="schematxninfo"></a>
<a id="schema_TxnInfo"></a>
<a id="tocStxninfo"></a>
<a id="tocstxninfo"></a>

```json
{
  "alloc_bytes": 0,
  "deadline": "2019-08-24T14:15:22Z",
  "id": [
    0
  ],
  "implicit": true,
  "is_historical": true,
  "max_alloc_bytes": 0,
  "num_auto_retries": 0,
  "num_retries": 0,
  "num_statements_executed": 0,
  "priority": "string",
  "read_only": true,
  "start": "2019-08-24T14:15:22Z",
  "txn_description": "string"
}

```

TxnInfo represents an in flight user transaction on some Session.

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|alloc_bytes|integer(int64)|false|none|Number of currently allocated bytes in the txn memory monitor.|
|deadline|string(date-time)|false|none|The deadline by which the transaction must be committed.|
|id|[UUID](#schemauuid)|false|none|none|
|implicit|boolean|false|none|implicit is true if this transaction was an implicit SQL transaction.|
|is_historical|boolean|false|none|none|
|max_alloc_bytes|integer(int64)|false|none|High water mark of allocated bytes in the txn memory monitor.|
|num_auto_retries|integer(int32)|false|none|num_retries is the number of times that this transaction was automatically<br>retried by the SQL executor.|
|num_retries|integer(int32)|false|none|num_retries is the number of times that this transaction was retried.|
|num_statements_executed|integer(int32)|false|none|num_statements_executed is the number of statements that were executed so<br>far on this transaction.|
|priority|string|false|none|none|
|read_only|boolean|false|none|none|
|start|string(date-time)|false|none|The start timestamp of the transaction.|
|txn_description|string|false|none|txn_description is a text description of the underlying kv.Txn, intended<br>for troubleshooting purposes.|

<h2 id="tocS_UUID">UUID</h2>
<!-- backwards compatibility -->
<a id="schemauuid"></a>
<a id="schema_UUID"></a>
<a id="tocSuuid"></a>
<a id="tocsuuid"></a>

```json
[
  0
]

```

UUID is an array type to represent the value of a UUID, as defined in RFC-4122.

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|UUID is an array type to represent the value of a UUID, as defined in RFC-4122.|[integer]|false|none|none|

<h2 id="tocS_UnresolvedAddr">UnresolvedAddr</h2>
<!-- backwards compatibility -->
<a id="schemaunresolvedaddr"></a>
<a id="schema_UnresolvedAddr"></a>
<a id="tocSunresolvedaddr"></a>
<a id="tocsunresolvedaddr"></a>

```json
{
  "address_field": "string",
  "network_field": "string"
}

```

UnresolvedAddr is an unresolved version of net.Addr.

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|address_field|string|false|none|none|
|network_field|string|false|none|none|

<h2 id="tocS_Version">Version</h2>
<!-- backwards compatibility -->
<a id="schemaversion"></a>
<a id="schema_Version"></a>
<a id="tocSversion"></a>
<a id="tocsversion"></a>

```json
{
  "internal": 0,
  "major_val": 0,
  "minor_val": 0,
  "patch": 0
}

```

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|internal|integer(int32)|false|none|The internal version is used to introduce migrations during the development<br>cycle. They are subversions that are never the end versions of a release,<br>i.e. users of stable, public release will only use binaries with the<br>internal version set to 0.|
|major_val|integer(int32)|false|none|none|
|minor_val|integer(int32)|false|none|none|
|patch|integer(int32)|false|none|Note that patch is a placeholder and will always be zero.|

<h2 id="tocS_hotRangesResponse">hotRangesResponse</h2>
<!-- backwards compatibility -->
<a id="schemahotrangesresponse"></a>
<a id="schema_hotRangesResponse"></a>
<a id="tocShotrangesresponse"></a>
<a id="tocshotrangesresponse"></a>

```json
{
  "next": "string",
  "ranges_by_node_id": {
    "property1": [
      {
        "end_key": [
          0
        ],
        "queries_per_second": 0,
        "range_id": 0,
        "start_key": [
          0
        ],
        "store_id": 0
      }
    ],
    "property2": [
      {
        "end_key": [
          0
        ],
        "queries_per_second": 0,
        "range_id": 0,
        "start_key": [
          0
        ],
        "store_id": 0
      }
    ]
  },
  "response_error": [
    {
      "error_message": "string",
      "node_id": 0
    }
  ]
}

```

Response struct for listHotRanges.

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|next|string|false|none|Continuation token for the next paginated call. Use as the `start`<br>parameter.|
|ranges_by_node_id|object|false|none|none|
|» **additionalProperties**|[[rangeDescriptorInfo](#schemarangedescriptorinfo)]|false|none|[rangeDescriptorInfo contains a subset of fields from roachpb.RangeDescriptor<br>that are safe to be returned from APIs.]|
|response_error|[[responseError](#schemaresponseerror)]|false|none|none|

<h2 id="tocS_listSessionsResp">listSessionsResp</h2>
<!-- backwards compatibility -->
<a id="schemalistsessionsresp"></a>
<a id="schema_listSessionsResp"></a>
<a id="tocSlistsessionsresp"></a>
<a id="tocslistsessionsresp"></a>

```json
{
  "errors": [
    {
      "message": "string",
      "node_id": 0
    }
  ],
  "next": "string",
  "sessions": [
    {
      "active_queries": [
        {
          "id": "string",
          "is_distributed": true,
          "phase": 0,
          "progress": 0,
          "sql": "string",
          "sql_anon": "string",
          "start": "2019-08-24T14:15:22Z",
          "txn_id": [
            0
          ]
        }
      ],
      "active_txn": {
        "alloc_bytes": 0,
        "deadline": "2019-08-24T14:15:22Z",
        "id": [
          0
        ],
        "implicit": true,
        "is_historical": true,
        "max_alloc_bytes": 0,
        "num_auto_retries": 0,
        "num_retries": 0,
        "num_statements_executed": 0,
        "priority": "string",
        "read_only": true,
        "start": "2019-08-24T14:15:22Z",
        "txn_description": "string"
      },
      "alloc_bytes": 0,
      "application_name": "string",
      "client_address": "string",
      "id": [
        0
      ],
      "last_active_query": "string",
      "last_active_query_anon": "string",
      "max_alloc_bytes": 0,
      "node_id": 0,
      "start": "2019-08-24T14:15:22Z",
      "username": "string"
    }
  ]
}

```

Response for listSessions.

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|errors|[[ListSessionsError](#schemalistsessionserror)]|false|none|Any errors that occurred during fan-out calls to other nodes.|
|next|string|false|none|The continuation token, for use in the next paginated call in the `start`<br>parameter.|
|sessions|[[Session](#schemasession)]|false|none|A list of sessions on this node or cluster.|

<h2 id="tocS_loginResponse">loginResponse</h2>
<!-- backwards compatibility -->
<a id="schemaloginresponse"></a>
<a id="schema_loginResponse"></a>
<a id="tocSloginresponse"></a>
<a id="tocsloginresponse"></a>

```json
{
  "session": "string"
}

```

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|session|string|false|none|Session string for a valid API session. Specify this in header for any API<br>requests that require authentication.|

<h2 id="tocS_logoutResponse">logoutResponse</h2>
<!-- backwards compatibility -->
<a id="schemalogoutresponse"></a>
<a id="schema_logoutResponse"></a>
<a id="tocSlogoutresponse"></a>
<a id="tocslogoutresponse"></a>

```json
{
  "logged_out": true
}

```

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|logged_out|boolean|false|none|Indicates whether logout was succeessful.|

<h2 id="tocS_nodeRangeResponse">nodeRangeResponse</h2>
<!-- backwards compatibility -->
<a id="schemanoderangeresponse"></a>
<a id="schema_nodeRangeResponse"></a>
<a id="tocSnoderangeresponse"></a>
<a id="tocsnoderangeresponse"></a>

```json
{
  "error": "string",
  "range_info": {
    "desc": {
      "end_key": [
        0
      ],
      "queries_per_second": 0,
      "range_id": 0,
      "start_key": [
        0
      ],
      "store_id": 0
    },
    "error_message": "string",
    "lease_history": [
      {
        "deprecated_start_stasis": {
          "logical": 0,
          "synthetic": true,
          "wall_time": 0
        },
        "epoch": 0,
        "expiration": {
          "logical": 0,
          "synthetic": true,
          "wall_time": 0
        },
        "proposed_ts": {
          "logical": 0,
          "synthetic": true,
          "wall_time": 0
        },
        "replica": {
          "node_id": 0,
          "replica_id": 0,
          "store_id": 0,
          "type": 0
        },
        "sequence": 0,
        "start": {
          "logical": 0,
          "synthetic": true,
          "wall_time": 0
        }
      }
    ],
    "problems": {
      "leader_not_lease_holder": true,
      "no_lease": true,
      "no_raft_leader": true,
      "overreplicated": true,
      "quiescent_equals_ticking": true,
      "raft_log_too_large": true,
      "unavailable": true,
      "underreplicated": true
    },
    "quiescent": true,
    "source_node_id": 0,
    "source_store_id": 0,
    "span": {
      "end_key": "string",
      "start_key": "string"
    },
    "stats": {
      "queries_per_second": 0,
      "writes_per_second": 0
    },
    "ticking": true
  }
}

```

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|error|string|false|none|none|
|range_info|[rangeInfo](#schemarangeinfo)|false|none|none|

<h2 id="tocS_nodeRangesResponse">nodeRangesResponse</h2>
<!-- backwards compatibility -->
<a id="schemanoderangesresponse"></a>
<a id="schema_nodeRangesResponse"></a>
<a id="tocSnoderangesresponse"></a>
<a id="tocsnoderangesresponse"></a>

```json
{
  "next": 0,
  "ranges": [
    {
      "desc": {
        "end_key": [
          0
        ],
        "queries_per_second": 0,
        "range_id": 0,
        "start_key": [
          0
        ],
        "store_id": 0
      },
      "error_message": "string",
      "lease_history": [
        {
          "deprecated_start_stasis": {
            "logical": 0,
            "synthetic": true,
            "wall_time": 0
          },
          "epoch": 0,
          "expiration": {
            "logical": 0,
            "synthetic": true,
            "wall_time": 0
          },
          "proposed_ts": {
            "logical": 0,
            "synthetic": true,
            "wall_time": 0
          },
          "replica": {
            "node_id": 0,
            "replica_id": 0,
            "store_id": 0,
            "type": 0
          },
          "sequence": 0,
          "start": {
            "logical": 0,
            "synthetic": true,
            "wall_time": 0
          }
        }
      ],
      "problems": {
        "leader_not_lease_holder": true,
        "no_lease": true,
        "no_raft_leader": true,
        "overreplicated": true,
        "quiescent_equals_ticking": true,
        "raft_log_too_large": true,
        "unavailable": true,
        "underreplicated": true
      },
      "quiescent": true,
      "source_node_id": 0,
      "source_store_id": 0,
      "span": {
        "end_key": "string",
        "start_key": "string"
      },
      "stats": {
        "queries_per_second": 0,
        "writes_per_second": 0
      },
      "ticking": true
    }
  ]
}

```

Response struct for listNodeRanges.

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|next|integer(int64)|false|none|none|
|ranges|[[rangeInfo](#schemarangeinfo)]|false|none|none|

<h2 id="tocS_nodeStatus">nodeStatus</h2>
<!-- backwards compatibility -->
<a id="schemanodestatus"></a>
<a id="schema_nodeStatus"></a>
<a id="tocSnodestatus"></a>
<a id="tocsnodestatus"></a>

```json
{
  "ServerVersion": {
    "internal": 0,
    "major_val": 0,
    "minor_val": 0,
    "patch": 0
  },
  "address": {
    "address_field": "string",
    "network_field": "string"
  },
  "attrs": {
    "attrs": [
      "string"
    ]
  },
  "build_tag": "string",
  "cluster_name": "string",
  "liveness_status": 0,
  "locality": {
    "tiers": [
      {
        "key": "string",
        "value": "string"
      }
    ]
  },
  "metrics": {
    "property1": 0,
    "property2": 0
  },
  "node_id": 0,
  "num_cpus": 0,
  "sql_address": {
    "address_field": "string",
    "network_field": "string"
  },
  "started_at": 0,
  "total_system_memory": 0,
  "updated_at": 0
}

```

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|ServerVersion|[Version](#schemaversion)|false|none|none|
|address|[UnresolvedAddr](#schemaunresolvedaddr)|false|none|none|
|attrs|[Attributes](#schemaattributes)|false|none|Attributes specifies a list of arbitrary strings describing<br>node topology, store type, and machine capabilities.|
|build_tag|string|false|none|none|
|cluster_name|string|false|none|none|
|liveness_status|[NodeLivenessStatus](#schemanodelivenessstatus)|false|none|TODO(irfansharif): We should reconsider usage of NodeLivenessStatus.<br>It's unclear if the enum is well considered. It enumerates across two<br>distinct set of things: the "membership" status (live/active,<br>decommissioning, decommissioned), and the node "process" status (live,<br>unavailable, available). It's possible for two of these "states" to be true,<br>simultaneously (consider a decommissioned, dead node). It makes for confusing<br>semantics, and the code attempting to disambiguate across these states<br>(kvserver.LivenessStatus() for e.g.) seem wholly arbitrary.<br><br>See #50707 for more details.|
|locality|[Locality](#schemalocality)|false|none|Locality is an ordered set of key value Tiers that describe a node's<br>location. The tier keys should be the same across all nodes.|
|metrics|object|false|none|Other fields that are a subset of roachpb.NodeStatus.|
|» **additionalProperties**|number(double)|false|none|none|
|node_id|[NodeID](#schemanodeid)|false|none|NodeID is a custom type for a cockroach node ID. (not a raft node ID)<br>0 is not a valid NodeID.|
|num_cpus|integer(int32)|false|none|none|
|sql_address|[UnresolvedAddr](#schemaunresolvedaddr)|false|none|none|
|started_at|integer(int64)|false|none|none|
|total_system_memory|integer(int64)|false|none|none|
|updated_at|integer(int64)|false|none|none|

<h2 id="tocS_nodesResponse">nodesResponse</h2>
<!-- backwards compatibility -->
<a id="schemanodesresponse"></a>
<a id="schema_nodesResponse"></a>
<a id="tocSnodesresponse"></a>
<a id="tocsnodesresponse"></a>

```json
{
  "next": 0,
  "nodes": [
    {
      "ServerVersion": {
        "internal": 0,
        "major_val": 0,
        "minor_val": 0,
        "patch": 0
      },
      "address": {
        "address_field": "string",
        "network_field": "string"
      },
      "attrs": {
        "attrs": [
          "string"
        ]
      },
      "build_tag": "string",
      "cluster_name": "string",
      "liveness_status": 0,
      "locality": {
        "tiers": [
          {
            "key": "string",
            "value": "string"
          }
        ]
      },
      "metrics": {
        "property1": 0,
        "property2": 0
      },
      "node_id": 0,
      "num_cpus": 0,
      "sql_address": {
        "address_field": "string",
        "network_field": "string"
      },
      "started_at": 0,
      "total_system_memory": 0,
      "updated_at": 0
    }
  ]
}

```

Response struct for listNodes.

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|next|integer(int64)|false|none|Continuation token for the next paginated call, if more values are present.<br>Specify as the `offset` parameter.|
|nodes|[[nodeStatus](#schemanodestatus)]|false|none|none|

<h2 id="tocS_rangeDescriptorInfo">rangeDescriptorInfo</h2>
<!-- backwards compatibility -->
<a id="schemarangedescriptorinfo"></a>
<a id="schema_rangeDescriptorInfo"></a>
<a id="tocSrangedescriptorinfo"></a>
<a id="tocsrangedescriptorinfo"></a>

```json
{
  "end_key": [
    0
  ],
  "queries_per_second": 0,
  "range_id": 0,
  "start_key": [
    0
  ],
  "store_id": 0
}

```

rangeDescriptorInfo contains a subset of fields from roachpb.RangeDescriptor
that are safe to be returned from APIs.

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|end_key|[RKey](#schemarkey)|false|none|Key is a custom type for a byte string in proto<br>messages which refer to Cockroach keys.|
|queries_per_second|number(double)|false|none|none|
|range_id|[RangeID](#schemarangeid)|false|none|none|
|start_key|[RKey](#schemarkey)|false|none|Key is a custom type for a byte string in proto<br>messages which refer to Cockroach keys.|
|store_id|[StoreID](#schemastoreid)|false|none|none|

<h2 id="tocS_rangeInfo">rangeInfo</h2>
<!-- backwards compatibility -->
<a id="schemarangeinfo"></a>
<a id="schema_rangeInfo"></a>
<a id="tocSrangeinfo"></a>
<a id="tocsrangeinfo"></a>

```json
{
  "desc": {
    "end_key": [
      0
    ],
    "queries_per_second": 0,
    "range_id": 0,
    "start_key": [
      0
    ],
    "store_id": 0
  },
  "error_message": "string",
  "lease_history": [
    {
      "deprecated_start_stasis": {
        "logical": 0,
        "synthetic": true,
        "wall_time": 0
      },
      "epoch": 0,
      "expiration": {
        "logical": 0,
        "synthetic": true,
        "wall_time": 0
      },
      "proposed_ts": {
        "logical": 0,
        "synthetic": true,
        "wall_time": 0
      },
      "replica": {
        "node_id": 0,
        "replica_id": 0,
        "store_id": 0,
        "type": 0
      },
      "sequence": 0,
      "start": {
        "logical": 0,
        "synthetic": true,
        "wall_time": 0
      }
    }
  ],
  "problems": {
    "leader_not_lease_holder": true,
    "no_lease": true,
    "no_raft_leader": true,
    "overreplicated": true,
    "quiescent_equals_ticking": true,
    "raft_log_too_large": true,
    "unavailable": true,
    "underreplicated": true
  },
  "quiescent": true,
  "source_node_id": 0,
  "source_store_id": 0,
  "span": {
    "end_key": "string",
    "start_key": "string"
  },
  "stats": {
    "queries_per_second": 0,
    "writes_per_second": 0
  },
  "ticking": true
}

```

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|desc|[rangeDescriptorInfo](#schemarangedescriptorinfo)|false|none|rangeDescriptorInfo contains a subset of fields from roachpb.RangeDescriptor<br>that are safe to be returned from APIs.|
|error_message|string|false|none|none|
|lease_history|[[Lease](#schemalease)]|false|none|[Lease contains information about range leases including the<br>expiration and lease holder.]|
|problems|[RangeProblems](#schemarangeproblems)|false|none|none|
|quiescent|boolean|false|none|none|
|source_node_id|[NodeID](#schemanodeid)|false|none|NodeID is a custom type for a cockroach node ID. (not a raft node ID)<br>0 is not a valid NodeID.|
|source_store_id|[StoreID](#schemastoreid)|false|none|none|
|span|[PrettySpan](#schemaprettyspan)|false|none|none|
|stats|[RangeStatistics](#schemarangestatistics)|false|none|none|
|ticking|boolean|false|none|none|

<h2 id="tocS_rangeResponse">rangeResponse</h2>
<!-- backwards compatibility -->
<a id="schemarangeresponse"></a>
<a id="schema_rangeResponse"></a>
<a id="tocSrangeresponse"></a>
<a id="tocsrangeresponse"></a>

```json
{
  "responses_by_node_id": {
    "property1": {
      "error": "string",
      "range_info": {
        "desc": {
          "end_key": [
            0
          ],
          "queries_per_second": 0,
          "range_id": 0,
          "start_key": [
            0
          ],
          "store_id": 0
        },
        "error_message": "string",
        "lease_history": [
          {
            "deprecated_start_stasis": {
              "logical": 0,
              "synthetic": true,
              "wall_time": 0
            },
            "epoch": 0,
            "expiration": {
              "logical": 0,
              "synthetic": true,
              "wall_time": 0
            },
            "proposed_ts": {
              "logical": 0,
              "synthetic": true,
              "wall_time": 0
            },
            "replica": {
              "node_id": 0,
              "replica_id": 0,
              "store_id": 0,
              "type": 0
            },
            "sequence": 0,
            "start": {
              "logical": 0,
              "synthetic": true,
              "wall_time": 0
            }
          }
        ],
        "problems": {
          "leader_not_lease_holder": true,
          "no_lease": true,
          "no_raft_leader": true,
          "overreplicated": true,
          "quiescent_equals_ticking": true,
          "raft_log_too_large": true,
          "unavailable": true,
          "underreplicated": true
        },
        "quiescent": true,
        "source_node_id": 0,
        "source_store_id": 0,
        "span": {
          "end_key": "string",
          "start_key": "string"
        },
        "stats": {
          "queries_per_second": 0,
          "writes_per_second": 0
        },
        "ticking": true
      }
    },
    "property2": {
      "error": "string",
      "range_info": {
        "desc": {
          "end_key": [
            0
          ],
          "queries_per_second": 0,
          "range_id": 0,
          "start_key": [
            0
          ],
          "store_id": 0
        },
        "error_message": "string",
        "lease_history": [
          {
            "deprecated_start_stasis": {
              "logical": 0,
              "synthetic": true,
              "wall_time": 0
            },
            "epoch": 0,
            "expiration": {
              "logical": 0,
              "synthetic": true,
              "wall_time": 0
            },
            "proposed_ts": {
              "logical": 0,
              "synthetic": true,
              "wall_time": 0
            },
            "replica": {
              "node_id": 0,
              "replica_id": 0,
              "store_id": 0,
              "type": 0
            },
            "sequence": 0,
            "start": {
              "logical": 0,
              "synthetic": true,
              "wall_time": 0
            }
          }
        ],
        "problems": {
          "leader_not_lease_holder": true,
          "no_lease": true,
          "no_raft_leader": true,
          "overreplicated": true,
          "quiescent_equals_ticking": true,
          "raft_log_too_large": true,
          "unavailable": true,
          "underreplicated": true
        },
        "quiescent": true,
        "source_node_id": 0,
        "source_store_id": 0,
        "span": {
          "end_key": "string",
          "start_key": "string"
        },
        "stats": {
          "queries_per_second": 0,
          "writes_per_second": 0
        },
        "ticking": true
      }
    }
  }
}

```

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|responses_by_node_id|object|false|none|none|
|» **additionalProperties**|[nodeRangeResponse](#schemanoderangeresponse)|false|none|none|

<h2 id="tocS_responseError">responseError</h2>
<!-- backwards compatibility -->
<a id="schemaresponseerror"></a>
<a id="schema_responseError"></a>
<a id="tocSresponseerror"></a>
<a id="tocsresponseerror"></a>

```json
{
  "error_message": "string",
  "node_id": 0
}

```

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|error_message|string|false|none|none|
|node_id|[NodeID](#schemanodeid)|false|none|NodeID is a custom type for a cockroach node ID. (not a raft node ID)<br>0 is not a valid NodeID.|

