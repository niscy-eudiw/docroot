# Prerequisites
# pandoc
#
# sudo apt install pandoc
#
# Parameters and Variables
# https://www.gnu.org/software/make/manual/html_node/Automatic-Variables.html#Automatic-Variables
GENERATED=	intro.html second.html

all: $(GENERATED)

# Gerenate html, doc from the html
intro.html: intro.md
	pandoc -s --from markdown --to html -o ./dist/$@.tmp $< --toc --metadata title="The European Digital Identity Wallet Reference Implementation" --metadata lang="en" --self-contained --css=styles/style.css -F node_modules/mermaid-filter/index.js --lua-filter fix-links-multiple-files.lua
	node fix.js ./dist/$@.tmp ./dist/$@

second.html: second.md
	pandoc -s --from markdown --to html -o ./dist/$@.tmp $< --toc --metadata title="The European Digital Identity Wallet Reference Implementation" --metadata lang="en" --self-contained --css=styles/style.css -F node_modules/mermaid-filter/index.js --lua-filter fix-links-multiple-files.lua
	node fix.js ./dist/$@.tmp ./dist/$@

# Run a local http server
serve:
	npx http-server .

prepare:
	mkdir -p dist
	npm install
	npm list

clean:
	echo $(GENERATED)
	rm -f $(GENERATED) intro.html.docx
	rm -f ./dist -R