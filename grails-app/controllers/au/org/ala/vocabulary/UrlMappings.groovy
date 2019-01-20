package au.org.ala.vocabulary

class UrlMappings {

    static mappings = {
        "/list" {
            controller = 'vocabulary'
            action = 'list'
        }
        "/show" {
            controller = 'vocabulary'
            action = 'show'
        }
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }

        "/" {
            controller = 'vocabulary'
            action = 'index'
        }
        "500"(view:'/error')
        "404"(view:'/notFound')
    }
}
