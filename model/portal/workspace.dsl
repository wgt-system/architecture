workspace extends ../../model/hub/workspace.dsl {
    model {
        !element wgt {
            url "${PORTAL_BASE_URL}/bounded-contexts/wgt/"
        }
        !element vocation {
            url "${PORTAL_BASE_URL}/bounded-contexts/vocation/"
        }
        !element illumination {
            url "${PORTAL_BASE_URL}/bounded-contexts/illumination/"
        }
        !element conveyance {
            url "${PORTAL_BASE_URL}/bounded-contexts/conveyance/"
        }
        !element orientation {
            url "${PORTAL_BASE_URL}/bounded-contexts/orientation/"
        }
    }

    views {
        properties {
            "plantuml.skinparams" "nodesep=60,ranksep=80"
        }
    }
}
