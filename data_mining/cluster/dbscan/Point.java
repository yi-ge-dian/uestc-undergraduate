package dbscan;

import java.util.ArrayList;

//clusterID
public class Point {

	private int x;
	private int y;
	private boolean visted;
	private int clusterid;
	
	public Point(int a, int b)
	{
		x = a;
		y = b;
		visted = false;
		clusterid = -1;
		
	}
	
	public int getX()
	{
		return x;
	}
	public int getY()
	{
		return y;
	}
	public boolean getVisted()
	{
		return visted;
	}
	public int getclusterid()
	{
		return clusterid;
	}
	public void vist()
	{
		visted = true;
	}
	public void setclusterid(int a)
	{
		clusterid = a;
	}
}
