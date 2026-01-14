#!/bin/bash
echo "=== Website Diagnostic Report ==="
echo ""
echo "1. Checking file structure..."
echo "   HTML files: $(find . -name '*.html' | wc -l)"
echo "   CSS files: $(find . -name '*.css' | wc -l)"
echo "   JS files: $(find . -name '*.js' | wc -l)"
echo ""
echo "2. Checking critical files..."
test -f index.html && echo "   ✓ index.html exists" || echo "   ✗ index.html missing"
test -f css/style.css && echo "   ✓ css/style.css exists" || echo "   ✗ css/style.css missing"
test -f js/jquery.js && echo "   ✓ js/jquery.js exists" || echo "   ✗ js/jquery.js missing"
test -f images/resources/logo.png && echo "   ✓ logo.png exists" || echo "   ✗ logo.png missing"
echo ""
echo "3. Checking server..."
if curl -s http://localhost:8080 > /dev/null; then
    echo "   ✓ Server responding on port 8080"
else
    echo "   ✗ Server not responding"
fi
echo ""
echo "4. Testing index.html loads..."
HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:8080/index.html)
if [ "$HTTP_CODE" = "200" ]; then
    echo "   ✓ index.html loads successfully (HTTP $HTTP_CODE)"
else
    echo "   ✗ index.html failed (HTTP $HTTP_CODE)"
fi
echo ""
echo "5. Access your website at:"
echo "   http://localhost:8080/index.html"
echo ""
echo "Diagnostic complete!"
