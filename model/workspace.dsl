workspace {
    name "We Got This! System Architecture"
    description "Design-time system landscape for the accepted wgt-system bounded contexts. The model visualizes existing architecture decisions and is subordinate to the normative Architecture Control Plane documentation and ADRs."
    !impliedRelationships false

    model {
        wgt = softwareSystem "Wiiii Got This" "Cross-platform integration and presentation of independently owned service capabilities." {
            tags "Bounded Context" "Integration"
        }

        vocation = softwareSystem "Vocation" "Local-first personal job-market bounded context and owner of job-market publication semantics." {
            tags "Bounded Context" "Domain"
        }

        illumination = softwareSystem "Illumination" "Local-first personal-learning bounded context and owner of learning semantics." {
            tags "Bounded Context" "Domain"
        }

        conveyance = softwareSystem "Conveyance" "Generic durable opaque cross-device delivery between trusted installations without ownership of foreign business semantics." {
            tags "Bounded Context" "Infrastructure"
        }

        orientation = softwareSystem "Orientation" "Generic geospatial bounded context for Discover, Explore, Navigate, and Current Location representation." {
            tags "Bounded Context" "Geospatial"
        }

        vocationToWgt = vocation -> wgt "Publishes provider-owned job-market capabilities to" {
            properties {
                "structurizr.inspection.model.relationship.technology" "info"
            }
        }
        illuminationToWgt = illumination -> wgt "Exposes Illumination-owned application/published boundaries to" {
            properties {
                "structurizr.inspection.model.relationship.technology" "info"
            }
        }
        wgtToConveyance = wgt -> conveyance "Uses for durable opaque cross-device delivery when required" {
            properties {
                "structurizr.inspection.model.relationship.technology" "info"
            }
        }
        orientationToWgt = orientation -> wgt "Provides generic geospatial capability for composition and presentation" {
            properties {
                "structurizr.inspection.model.relationship.technology" "info"
            }
        }
        vocationToOrientation = vocation -> orientation "Consumes generic geospatial results when interpreting provider-owned data" {
            properties {
                "structurizr.inspection.model.relationship.technology" "info"
            }
        }
    }

    views {
        systemLandscape SystemLandscape {
            include wgt
            include vocation
            include illumination
            include conveyance
            include orientation
            autolayout lr 220 120
            default
            title "We Got This! — System Landscape"
            description "Accepted bounded contexts and their major system-facing relationships."
        }

        terminology {
            softwareSystem "Bounded Context"
        }

        styles {
            element "Bounded Context" {
                shape RoundedBox
                width 360
                height 200
                color #FFFFFF
                stroke #263238
                strokeWidth 2
                fontSize 20
                description false
            }

            element "Integration" {
                background #1F5A67
            }

            element "Domain" {
                background #40566B
            }

            element "Infrastructure" {
                background #5A526F
            }

            element "Geospatial" {
                background #2F6F5E
            }

            relationship "Relationship" {
                color #667085
                thickness 2
                width 240
                fontSize 16
            }
        }
    }

    configuration {
        scope landscape
    }
}
