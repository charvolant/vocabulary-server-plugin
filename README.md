# Vocabulary Server Plugin

A skinnable plugin that can be used in conjunction with the
[vocabulary plugin](../vocabulary-plugin) and the
[vocabulary service](../vocabulary-service) to provide a front end for the
ALA vocabulary service.

Resources can be listed, searched and displayed, using the formatting information
supplied by the service.

## Configuration

The server needs to be configured according to the configuration in
[the vocabulary plugin](../vocabulary-plugin/README.md#configuration).
**vocabulary.server** needs to point to this server instance.
**vocabulary.service** needs to point to the vocabulary service.

## Skinning

As a stand-alone application, this runs using a minimal bootstrap/jQuery import from `base.gsp`.
Applications can use other, more sophisticated, layouts by creating an application
and using this plugin as a dependency.