var path = require('path');
var lysisUtils = require('api-lysis').utils;

var restangularServicesGenerator = function(parameters) {

  var templatePath = path.join(__dirname, 'templates');

  // templates
  lysisUtils.registerTemplate('resource-service', path.join(templatePath, 'resource-service.ts.tpl'));
  lysisUtils.registerTemplate('index', path.join(templatePath, 'index.ts.tpl'));
  lysisUtils.registerTemplate('app-module-addendum', path.join(templatePath, 'app-module-addendum.tpl'));

  var basePath = path.join(parameters.config.basePath, (parameters.generatorConfig.dir ? parameters.generatorConfig.dir : 'backend-services'));
  parameters.context.basePath = basePath;

  lysisUtils.createDir(path.join(basePath));

  if (!parameters.generatorConfig.classPath) {
    parameters.generatorConfig.classPath = '../backend-classes';
  }

  lysisUtils.copyFile(path.join(templatePath, 'backend-service.ts.tpl'), `${basePath}/backend.service.ts`);
  lysisUtils.copyFile(path.join(templatePath, 'RestangularConfigFactory.ts.tpl'), `${basePath}/RestangularConfigFactory.ts`);
  lysisUtils.copyFile(path.join(templatePath, 'backend-config.interface.ts.tpl'), `${basePath}/backend-config.interface.ts`);
  if (!lysisUtils.exists(`${basePath}/backend-config.ts`)) {
    lysisUtils.copyFile(path.join(templatePath, 'backend-config.ts.tpl'), `${basePath}/backend-config.ts`);
  }

  // create resources files from templates
  for (var resourceName in parameters.context.resources) {
    var resource = parameters.context.resources[resourceName];
    var context = { resource: resource, classPath: parameters.generatorConfig.classPath };
    var className = lysisUtils.toCamelCase(resource.name, 'upper');

    // if service target files exists, do not overwrite (except when required from config)
    if (!lysisUtils.exists(`${basePath}/${className}.service.ts`)) {
      lysisUtils.createFile('resource-service', `${basePath}/${className}.service.ts`, context);
    }
  }

  // create index file
  lysisUtils.createFile('index', `${basePath}/index.ts`, parameters.context);

  console.log(lysisUtils.evalTemplate('app-module-addendum', parameters.context));
};

// Test the generator when starting `node index.js` directly
if (require.main === module) {
  lysisUtils.getGeneratorTester()
  .setUrl('http://127.0.0.1:8000')
  // .setUrl('https://demo.api-platform.com')
  .setGenerator(restangularServicesGenerator)
  .test();
}

module.exports = restangularServicesGenerator;
