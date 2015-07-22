typedef struct {
    float Position[3];
    float TexCoord[2];
    float Normal[3];
} Vertex;

typedef struct {
    float Position[3];
    float normal[3];
} Vert;

typedef struct {
    float Position[3];
    float Normal[3];
    float Color[4];
} coloredVertex;

typedef struct {
    float Position[3];
    float normal[3];
    float texel[2];
} texVertex;

typedef struct{
    GLubyte ind;
}indices;