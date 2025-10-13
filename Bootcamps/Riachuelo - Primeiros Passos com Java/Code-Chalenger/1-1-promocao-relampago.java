import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
public class CalculaDesconto{public static void main(String[]args)throws IOException{String s=new BufferedReader(new InputStreamReader(System.in)).readLine();if(s==null||s.isEmpty())return;long i=0,f=0;int d=0;boolean m=false;for(char c:s.toCharArray()){if(c=='.'||c==','){m=true;continue;}if(c>='0'&&c<='9'){if(m){if(d<2){f=f*10+(c-'0');d++;}}else{i=i*10+(c-'0');}}}if(d==1)f*=10;long cents=i*100+f;System.out.println("Desconto de "+(cents<5000?"0%":cents<=10000?"10%":"20%"));}}
