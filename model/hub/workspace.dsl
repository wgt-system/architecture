workspace extends https://raw.githubusercontent.com/wgt-system/architecture/dev/model/workspace.dsl {
    properties {
        "structurizr.introduction" "false"
        "structurizr.inspection.workspace.scope" "info"
    }

    model {
        !include https://raw.githubusercontent.com/wgt-system/wiiii-got-this/dev/docs/model/model.dsl

        !relationship vocationToWgt {
            properties {
                "structurizr.inspection.model.relationship.technology" "info"
            }
        }

        !relationship illuminationToWgt {
            properties {
                "structurizr.inspection.model.relationship.technology" "info"
            }
        }

        !relationship wgtToConveyance {
            properties {
                "structurizr.inspection.model.relationship.technology" "info"
            }
        }

        !relationship orientationToWgt {
            properties {
                "structurizr.inspection.model.relationship.technology" "info"
            }
        }

        !relationship vocationToOrientation {
            properties {
                "structurizr.inspection.model.relationship.technology" "info"
            }
        }
    }

    views {
        properties {
            "structurizr.sort" "created"
        }

        !include https://raw.githubusercontent.com/wgt-system/wiiii-got-this/dev/docs/model/views.dsl
    }

    configuration {
        scope none
    }
}
