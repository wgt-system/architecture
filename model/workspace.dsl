workspace {
    name "We Got This! System Architecture"
    description "Design-time system landscape for the accepted wgt-system bounded contexts. The model visualizes existing architecture decisions and is subordinate to the normative Architecture Control Plane documentation and ADRs."
    !impliedRelationships false

    model {
        wgt = softwareSystem "Wiiii Got This" "Cross-platform integration and presentation of independently owned service capabilities." {
            tags "Bounded Context" "Integration"
        }

        vocation = softwareSystem "Vocation" "Local-first personal job-market bounded context and owner of job-market research/publication semantics." {
            tags "Bounded Context" "Domain"
        }

        illumination = softwareSystem "Illumination" "Local-first personal-learning bounded context and owner of learning/content-import semantics." {
            tags "Bounded Context" "Domain"
        }

        conveyance = softwareSystem "Conveyance" "Generic durable opaque cross-device delivery between trusted installations without ownership of foreign business semantics." {
            tags "Bounded Context" "Infrastructure"
        }

        orientation = softwareSystem "Orientation" "Local-first personal spatial exploration and mobility bounded context; also the reusable generic geospatial owner for Discover, Explore, Navigate and Current Location." {
            tags "Bounded Context" "Geospatial" "Domain"
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
        orientationToWgt = orientation -> wgt "Exposes Orientation-owned capability for cross-platform composition and presentation" {
            properties {
                "structurizr.inspection.model.relationship.technology" "info"
            }
        }
        vocationToOrientation = vocation -> orientation "Consumes generic geospatial/mobility results when interpreting provider-owned job data" {
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
            autolayout tb 180 120
            default
            title "We Got This! — System Landscape"
            description "Accepted bounded contexts and their major system-facing relationships."
        }

        systemContext wgt WgtContext {
            include *?
            autolayout tb 180 120
            title "Wiiii Got This — System Context"
        }

        systemContext vocation VocationContext {
            include *?
            autolayout tb 180 120
            title "Vocation — System Context"
        }

        systemContext illumination IlluminationContext {
            include *?
            autolayout tb 180 120
            title "Illumination — System Context"
        }

        systemContext conveyance ConveyanceContext {
            include *?
            autolayout tb 180 120
            title "Conveyance — System Context"
        }

        systemContext orientation OrientationContext {
            include *?
            autolayout tb 180 120
            title "Orientation — System Context"
        }

        terminology {
            softwareSystem "Bounded Context"
        }

        styles {
            element "Bounded Context" {
                shape Box
                width 360
                height 200
                background #F7F7F5
                color #1F2933
                stroke #4B5563
                strokeWidth 1
                fontSize 20
                description false
            }

            relationship "Relationship" {
                color #6B7280
                thickness 1
                width 240
                fontSize 15
            }
        }
    }

    configuration {
        scope landscape
    }
}
