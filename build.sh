#!/bin/bash
echo "🔨 Iniciando build do TCC..."
echo ""

# Limpar arquivos antigos
echo "🧹 Limpando arquivos auxiliares..."
rm -f *.aux *.toc *.out *.bbl *.blg *.bcf *.log *.run.xml *.mw *.fls *.fdb_latexmk

# Primeira compilação
echo "📄 Primeira compilação..."
pdflatex -interaction=nonstopmode main.tex > /tmp/build1.log 2>&1

# Processar referências
echo "📚 Processando referências bibliográficas..."
biber main > /tmp/biber.log 2>&1

# Segunda compilação
echo "📄 Segunda compilação..."
pdflatex -interaction=nonstopmode main.tex > /tmp/build2.log 2>&1

# Terceira compilação (final)
echo "📄 Compilação final..."
pdflatex -interaction=nonstopmode main.tex > /tmp/build3.log 2>&1

# Verificar resultado
if [ -f main.pdf ]; then
    PAGES=$(pdfinfo main.pdf | grep Pages | awk '{print $2}')
    SIZE=$(ls -lh main.pdf | awk '{print $5}')
    echo ""
    echo "✅ BUILD CONCLUÍDO COM SUCESSO!"
    echo "📊 Páginas: $PAGES"
    echo "💾 Tamanho: $SIZE"
    echo "📁 Arquivo: $(pwd)/main.pdf"
else
    echo ""
    echo "❌ ERRO: PDF não foi gerado!"
    echo "Verifique os logs em /tmp/build*.log"
fi
