#!/usr/bin/python

# List all the modules in a phthon package called Bio.Blast

import pkgutil
import Bio.Blast
package = Bio.Blast
for importer, modname, ispkg in pkgutil.iter_modules(package.__path__):
 print "Found submodule %s (is a package: %s)" % (modname, ispkg)