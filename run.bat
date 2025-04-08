echo \" <<'NIX' >/dev/null ">NUL "\"
@echo off
setlocal EnableDelayedExpansion

set "root=%~dp0"
rem Hack to split a string.
set ^"root=!root:\node_modules\=^

!"
set root=%root%
set "NODE_PATH=%root%\node_modules;%NODE_PATH%"

node --enable-source-maps --expose-gc -e "eval(fs.readFileSync(process.argv.at(1), 'utf-8').split('---').pop())" "%~f0" %*
exit /b %errorlevel%

NIX

# NODE_PATH ensures TypeScript is found when running straight from npm repo using npx.
NODE_PATH="${0%/node_modules/*}/node_modules:$NODE_PATH" /usr/bin/env -S node --enable-source-maps --expose-gc -e "eval(fs.readFileSync(process.argv.at(1), 'utf-8').split('---').pop())" $0 $@
exit $?

---

const path = require('path');
const fs = require('fs');

function shift() { process.argv.splice(1, 1); }

shift();

while(process.argv[1] == '-p') {
	shift();
	require(process.argv[1]);
	shift();
}

const ts = require('typescript');

require.extensions['.ts'] = function(module, key) {
	module._compile(
		ts.transpileModule(fs.readFileSync(key, 'utf-8'), {
			fileName: key,
			compilerOptions: {
				esModuleInterop: true,
				inlineSourceMap: true,
				module: ts.ModuleKind.CommonJS,
				target: ts.ScriptTarget.ES2018
			}
		}).outputText,
		key
	);
};

require(path.resolve(process.argv[1]));
