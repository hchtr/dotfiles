package main

import (
	"database/sql"
	"fmt"
	"log"
	"os"
	"path/filepath"
	"sort"
	"strings"

	_ "modernc.org/sqlite" 
)

type Document struct {
	Bookmarks []string
	Marks     []string
}

func getSioyekPaths() (string, string) {
	home, err := os.UserHomeDir()
	if err != nil {
		log.Fatalf("Could not locate home directory: %v", err)
	}

	baseDir := filepath.Join(home, ".local", "share", "sioyek")
	if _, err := os.Stat(baseDir); os.IsNotExist(err) {
		baseDir = filepath.Join(home, ".config", "sioyek")
	}

	return filepath.Join(baseDir, "local.db"), filepath.Join(baseDir, "shared.db")
}

func main() {
	localDb, sharedDb := getSioyekPaths()

	if _, err := os.Stat(localDb); os.IsNotExist(err) {
		log.Fatalf(" Error: local.db not found at %s", localDb)
	}
	if _, err := os.Stat(sharedDb); os.IsNotExist(err) {
		log.Fatalf(" Error: shared.db not found at %s", sharedDb)
	}

	db, err := sql.Open("sqlite", sharedDb)
	if err != nil {
		log.Fatalf("Failed to open shared database: %v", err)
	}
	defer db.Close()

	attachQuery := fmt.Sprintf("ATTACH DATABASE '%s' AS local_db;", filepath.ToSlash(localDb))
	_, err = db.Exec(attachQuery)
	if err != nil {
		log.Fatalf("Failed to bridge Sioyek databases: %v", err)
	}

	sqlQuery := `
		SELECT 
			'bookmark' as entry_type,
			COALESCE(lh.path, b.document_path) as pdf_path,
			b.desc as entry_detail
		FROM bookmarks b
		LEFT JOIN local_db.document_hash lh ON b.document_path = lh.hash
		
		UNION ALL
		
		SELECT 
			'mark' as entry_type,
			COALESCE(lh.path, m.document_path) as pdf_path,
			m.symbol as entry_detail
		FROM marks m
		LEFT JOIN local_db.document_hash lh ON m.document_path = lh.hash
		ORDER BY pdf_path;`

	rows, err := db.Query(sqlQuery)
	if err != nil {
		log.Fatalf("Database query failed: %v", err)
	}
	defer rows.Close()

	dataStructure := make(map[string]*Document)

	for rows.Next() {
		var entryType, pdfPath, entryDetail string
		if err := rows.Scan(&entryType, &pdfPath, &entryDetail); err != nil {
			log.Fatal(err)
		}

		filename := filepath.Base(pdfPath)
		if pdfPath == "" {
			filename = "Unknown/Unindexed Document"
		}

		if _, exists := dataStructure[filename]; !exists {
			dataStructure[filename] = &Document{}
		}

		if entryType == "bookmark" {
			dataStructure[filename].Bookmarks = append(dataStructure[filename].Bookmarks, entryDetail)
		} else if entryType == "mark" {
			dataStructure[filename].Marks = append(dataStructure[filename].Marks, fmt.Sprintf("[%s]", entryDetail))
		}
	}

	fmt.Println(strings.Repeat("=", 75))
	fmt.Println(strings.Repeat(" ", 26) + "SIOYEK QUERY DASHBOARD")
	fmt.Println(strings.Repeat("=", 75))

	if len(dataStructure) == 0 {
		fmt.Println("No bookmarks or marks found.")
		return
	}

	var filenames []string
	for name := range dataStructure {
		filenames = append(filenames, name)
	}
	sort.Strings(filenames)

	for _, docName := range filenames {
		doc := dataStructure[docName]
		fmt.Printf("\n   %s\n", docName)
		fmt.Printf("   %s\n", strings.Repeat("-", len(docName)))

		if len(doc.Bookmarks) > 0 {
			fmt.Println("     Bookmarks:")
			for _, b := range doc.Bookmarks {
				fmt.Printf("     • %s\n", b)
			}
		}

		if len(doc.Marks) > 0 {
			fmt.Printf("     Quick Marks: %s\n", strings.Join(doc.Marks, ", "))
		}
	}

	fmt.Println("\n" + strings.Repeat("=", 75))
}
