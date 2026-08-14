workspace extends https://raw.githubusercontent.com/wgt-system/architecture/dev/model/workspace.dsl {
    model {
        !include https://raw.githubusercontent.com/wgt-system/wiiii-got-this/dev/docs/model/model.dsl
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
