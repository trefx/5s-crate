{
    "$graph": [
        {
            "class": "CommandLineTool",
            "id": "#rquest-oneshot.cwl",
            "label": "rquest-oneshot",
            "hints": [
                {
                    "dockerPull": "pszdldocker/rquest-oneshot:latest",
                    "class": "DockerRequirement"
                }
            ],
            "requirements": [
                {
                    "envDef": [
                        {
                            "envValue": "$(inputs.db_name)",
                            "envName": "DATASOURCE_DB_DATABASE"
                        },
                        {
                            "envValue": "$(inputs.db_host)",
                            "envName": "DATASOURCE_DB_HOST"
                        },
                        {
                            "envValue": "$(inputs.db_password)",
                            "envName": "DATASOURCE_DB_PASSWORD"
                        },
                        {
                            "envValue": "$(inputs.db_user)",
                            "envName": "DATASOURCE_DB_USERNAME"
                        }
                    ],
                    "class": "EnvVarRequirement"
                }
            ],
            "baseCommand": [
                "rquest-omop-agent"
            ],
            "inputs": [
                {
                    "type": "string",
                    "inputBinding": {
                        "position": 1,
                        "prefix": "--body"
                    },
                    "id": "#rquest-oneshot.cwl/rquest-oneshot/body"
                },
                {
                    "type": "string",
                    "id": "#rquest-oneshot.cwl/rquest-oneshot/db_host"
                },
                {
                    "type": "string",
                    "id": "#rquest-oneshot.cwl/rquest-oneshot/db_name"
                },
                {
                    "type": "string",
                    "id": "#rquest-oneshot.cwl/rquest-oneshot/db_password"
                },
                {
                    "type": "string",
                    "id": "#rquest-oneshot.cwl/rquest-oneshot/db_user"
                },
                {
                    "type": "boolean",
                    "inputBinding": {
                        "position": 3,
                        "prefix": "-a"
                    },
                    "id": "#rquest-oneshot.cwl/rquest-oneshot/is_availability"
                },
                {
                    "type": [
                        "null",
                        "string"
                    ],
                    "inputBinding": {
                        "position": 2,
                        "prefix": "-m"
                    },
                    "id": "#rquest-oneshot.cwl/rquest-oneshot/result_modifiers"
                },
                {
                    "type": [
                        "null",
                        "string"
                    ],
                    "inputBinding": {
                        "position": 4,
                        "prefix": "-o"
                    },
                    "id": "#rquest-oneshot.cwl/rquest-oneshot/results"
                }
            ],
            "outputs": [
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "output.json"
                    },
                    "id": "#rquest-oneshot.cwl/rquest-oneshot/output_file"
                }
            ]
        },
        {
            "class": "Workflow",
            "id": "#main",
            "label": "hutch-workflow",
            "inputs": [
                {
                    "type": "string",
                    "id": "#main/body"
                },
                {
                    "type": "string",
                    "id": "#main/db_host"
                },
                {
                    "type": "string",
                    "id": "#main/db_name"
                },
                {
                    "type": "string",
                    "id": "#main/db_password"
                },
                {
                    "type": "string",
                    "id": "#main/db_user"
                },
                {
                    "type": "boolean",
                    "id": "#main/is_availability"
                },
                {
                    "type": [
                        "null",
                        "string"
                    ],
                    "id": "#main/result_modifiers"
                },
                {
                    "type": [
                        "null",
                        "string"
                    ],
                    "id": "#main/results"
                }
            ],
            "outputs": [
                {
                    "type": "File",
                    "outputSource": "#main/rquest_oneshot/output_file",
                    "id": "#main/output_file"
                }
            ],
            "steps": [
                {
                    "run": "#rquest-oneshot.cwl",
                    "in": [
                        {
                            "source": "#main/body",
                            "id": "#main/rquest_oneshot/body"
                        },
                        {
                            "source": "#main/db_host",
                            "id": "#main/rquest_oneshot/db_host"
                        },
                        {
                            "source": "#main/db_name",
                            "id": "#main/rquest_oneshot/db_name"
                        },
                        {
                            "source": "#main/db_password",
                            "id": "#main/rquest_oneshot/db_password"
                        },
                        {
                            "source": "#main/db_user",
                            "id": "#main/rquest_oneshot/db_user"
                        },
                        {
                            "source": "#main/is_availability",
                            "id": "#main/rquest_oneshot/is_availability"
                        },
                        {
                            "source": "#main/result_modifiers",
                            "id": "#main/rquest_oneshot/result_modifiers"
                        },
                        {
                            "source": "#main/results",
                            "id": "#main/rquest_oneshot/results"
                        }
                    ],
                    "out": [
                        "#main/rquest_oneshot/output_file"
                    ],
                    "id": "#main/rquest_oneshot"
                }
            ]
        }
    ],
    "cwlVersion": "v1.0"
}
