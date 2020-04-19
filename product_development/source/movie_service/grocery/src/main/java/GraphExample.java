import com.google.gson.Gson;
import org.jgrapht.Graph;
import org.jgrapht.graph.DefaultDirectedGraph;
import org.jgrapht.graph.DefaultEdge;
import org.jgrapht.graph.SimpleGraph;
import org.jgrapht.graph.builder.GraphTypeBuilder;
import org.jgrapht.io.ComponentAttributeProvider;
import org.jgrapht.io.ComponentNameProvider;
import org.jgrapht.io.EdgeProvider;
import org.jgrapht.io.VertexProvider;
import org.jgrapht.nio.GraphExporter;
import org.jgrapht.nio.json.JSONExporter;
import org.jgrapht.nio.json.JSONImporter;
import org.jgrapht.util.SupplierUtil;

import java.io.*;
import java.util.HashMap;
import java.util.function.Consumer;
import java.util.function.Function;
import java.util.function.Supplier;

public class GraphExample {

    public static void main(String[] args) {
        Graph<String, DefaultEdge> g = new DefaultDirectedGraph<>(DefaultEdge.class);
        Graph<MyVertex, DefaultEdge> gIm = new DefaultDirectedGraph<>(DefaultEdge.class);
        String v1 = new String("simpleV1");
        String v2 = new String("v2");
        String v3 = new String("v3");
        String v4 = new String("v4");

        // add the vertices
        g.addVertex("simpleV1");
        g.addVertex("v2");
        g.addVertex("v3");
        g.addVertex("v4");

        // add edges to create a circuit
        g.addEdge(v1, v2);
        g.addEdge(v2, v3);
        g.addEdge(v3, v4);
        g.addEdge(v4, v1);
        g.addEdge(v4, v2);

        Function<String, String> vertexIdProvider = new Function<String, String>() {
            @Override
            public String apply(String s) {
                return s;
            }
        };
        JSONExporter<String, DefaultEdge> jsonExporter = new JSONExporter<>(vertexIdProvider);

//        System.out.println(g.outgoingEdgesOf("v4"));
        JSONExporter<String, DefaultEdge> gfg=  new JSONExporter<>();

        Writer writer = new StringWriter();
        jsonExporter.exportGraph(g, writer);
        System.out.println(writer);


        // @formatter:off
        String input = "{\n"
                + "  \"nodes\": [\n"
                + "  { \"id\":\"1\" },\n"
                + "  { \"id\":\"2\" },\n"
                + "  { \"id\":\"3\" },\n"
                + "  { \"id\":\"4\" }\n"
                + "  ],\n"
                + "  \"edges\": [\n"
                + "  { \"source\":\"1\", \"target\":\"2\" },\n"
                + "  { \"source\":\"1\", \"target\":\"3\" }\n"
                + "  ]\n"
                + "}";
        input = writer.toString();
        // @formatter:on

        Graph<String,
                DefaultEdge> g1 = GraphTypeBuilder
                .undirected().allowingMultipleEdges(true).allowingSelfLoops(true)
                .vertexSupplier(SupplierUtil.createStringSupplier())
                .edgeSupplier(SupplierUtil.DEFAULT_EDGE_SUPPLIER).buildGraph();

        JSONImporter<String, DefaultEdge> importer = new JSONImporter<>();
        importer.importGraph(g1, new StringReader(input));
        System.out.println(g1);

    }

    private static class MyVertexSupplier implements Supplier<MyVertex>, Serializable {
        private static final long serialVersionUID = -5025488316341437260L;

        public MyVertexSupplier() {
        }

        public MyVertex get() {
            return new MyVertex("test" );
        }
    }

    public static class MyVertex {
        private String label;

        public MyVertex(String l) {
            label = l;
        }

        public String getLabel() {
            return label;
        }

        public void setLabel(String label) {
            this.label = label;
        }

        @Override
        public String toString() {
            return "MyVertex{" +
                    "label='" + label + '\'' +
                    '}';
        }
    }
}
