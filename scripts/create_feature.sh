#!/bin/bash

# Script to create a new feature with Clean Architecture structure
# Usage: ./scripts/create_feature.sh [feature_name]

FEATURES_DIR="lib/features"

# Function to display usage
usage() {
    echo "Usage: $0 <feature_name>"
    echo "Example: $0 messaging"
    exit 1
}

# Check if feature name is provided
if [ -z "$1" ]; then
    read -p "Enter feature name (lowercase, use underscores for spaces): " FEATURE_NAME
else
    FEATURE_NAME=$1
fi

# Validate feature name
if [ -z "$FEATURE_NAME" ]; then
    echo "Error: Feature name cannot be empty"
    usage
fi

# Convert to lowercase and validate
FEATURE_NAME=$(echo "$FEATURE_NAME" | tr '[:upper:]' '[:lower:]' | tr ' ' '_')

# Check if feature already exists
if [ -d "$FEATURES_DIR/$FEATURE_NAME" ]; then
    echo "Error: Feature '$FEATURE_NAME' already exists in $FEATURES_DIR"
    exit 1
fi

# Create feature directory structure
echo "Creating feature: $FEATURE_NAME"

# Create main feature directory
mkdir -p "$FEATURES_DIR/$FEATURE_NAME"

# Create data layer
mkdir -p "$FEATURES_DIR/$FEATURE_NAME/data/datasources"
mkdir -p "$FEATURES_DIR/$FEATURE_NAME/data/models"
mkdir -p "$FEATURES_DIR/$FEATURE_NAME/data/repositories"

# Create domain layer
mkdir -p "$FEATURES_DIR/$FEATURE_NAME/domain/entities"
mkdir -p "$FEATURES_DIR/$FEATURE_NAME/domain/repositories"
mkdir -p "$FEATURES_DIR/$FEATURE_NAME/domain/usecases"

# Create presentation layer
mkdir -p "$FEATURES_DIR/$FEATURE_NAME/presentation/bloc"
mkdir -p "$FEATURES_DIR/$FEATURE_NAME/presentation/pages"
mkdir -p "$FEATURES_DIR/$FEATURE_NAME/presentation/widgets"

echo "✅ Feature '$FEATURE_NAME' created successfully!"
echo "📁 Location: $FEATURES_DIR/$FEATURE_NAME"
echo ""
echo "Directory structure created:"
echo "├── data/"
echo "│   ├── datasources/"
echo "│   ├── models/"
echo "│   └── repositories/"
echo "├── domain/"
echo "│   ├── entities/"
echo "│   ├── repositories/"
echo "│   └── usecases/"
echo "└── presentation/"
echo "    ├── bloc/"
echo "    ├── pages/"
echo "    └── widgets/"
