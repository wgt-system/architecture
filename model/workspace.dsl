workspace {
    name "We Got This! System Architecture"
    description "Design-time system landscape for the accepted wgt-system bounded contexts. The model visualizes existing architecture decisions and is subordinate to the normative Architecture Control Plane documentation and ADRs."
    !impliedRelationships false

    model {
        wgt = softwareSystem "Wiiii Got This" "Cross-platform integration and presentation of independently owned service capabilities." {
            tags "Bounded Context" "Integration"
            url "https://github.com/wgt-system/wiiii-got-this"
        }

        vocation = softwareSystem "Vocation" "Local-first personal job-market bounded context and owner of job-market publication semantics." {
            tags "Bounded Context" "Domain"
            url "https://github.com/wgt-system/vocation"
        }

        illumination = softwareSystem "Illumination" "Local-first personal-learning bounded context and owner of learning semantics." {
            tags "Bounded Context" "Domain"
            url "https://github.com/wgt-system/illumination"
        }

        conveyance = softwareSystem "Conveyance" "Generic durable opaque cross-device delivery between trusted installations without ownership of foreign business semantics." {
            tags "Bounded Context" "Infrastructure"
            url "https://github.com/wgt-system/conveyance"
        }

        vocation -> wgt "Publishes provider-owned job-market capabilities to"
        illumination -> wgt "Exposes Illumination-owned application/published boundaries to"
        wgt -> conveyance "Uses for durable opaque cross-device delivery when required"
    }

    views {
        systemLandscape SystemLandscape {
            include wgt
            include vocation
            include illumination
            include conveyance
            autolayout lr
            title "We Got This! — System Landscape"
            description "Accepted bounded contexts and their major system-facing relationships."
        }

        systemContext wgt WgtContext {
            include *?
            autolayout lr
            title "Wiiii Got This — System Context"
            description "WGT in relation to the accepted bounded contexts whose capabilities it integrates or whose generic delivery capability it uses."
        }

        systemContext vocation VocationContext {
            include *?
            autolayout lr
            title "Vocation — System Context"
            description "Vocation and its accepted system-facing relationship with Wiiii Got This."
        }

        systemContext illumination IlluminationContext {
            include *?
            autolayout lr
            title "Illumination — System Context"
            description "Illumination and its accepted system-facing relationship with Wiiii Got This."
        }

        systemContext conveyance ConveyanceContext {
            include *?
            autolayout lr
            title "Conveyance — System Context"
            description "Conveyance as the accepted generic durable opaque delivery capability used by Wiiii Got This when required."
        }

        terminology {
            softwareSystem "Bounded Context"
        }

        styles {
            element "Bounded Context" {
                shape RoundedBox
                color #FFFFFF
                fontSize 24
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

            relationship "Relationship" {
                color #667085
                thickness 2
                fontSize 18
            }
        }
    }

    configuration {
        scope landscape
    }
}
