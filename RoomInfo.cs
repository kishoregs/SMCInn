using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SMCInn
{
    public class RoomInfo
    {

        [Microsoft.SqlServer.Server.SqlProcedure(Name = "GetInformation")]
        public static void GetInformation(out SqlString result, string criterion)
        {
            using (SqlConnection conCeilInn =
            new SqlConnection("context connection=true"))
            {
                SqlString roomNumber = "";
                SqlString roomType = "";
                SqlString bedType = "";
                SqlDecimal rate = 0M;

                conCeilInn.Open();
                SqlCommand cmdRoom = new SqlCommand("SELECT RoomNumber,  " +
                                             "RoomType, BedType, Rate " +
                                             "FROM Rooms WHERE RoomNumber = '" +
                                             criterion + "'", conCeilInn);
                SqlDataReader rdrRoom = cmdRoom.ExecuteReader();

                using (rdrRoom)
                {
                    while (rdrRoom.Read())
                    {
                        roomNumber = rdrRoom.GetSqlString(0);
                        roomType = rdrRoom.GetSqlString(1);
                        bedType = rdrRoom.GetSqlString(2);
                        rate = rdrRoom.GetDecimal(3);
                    }

                    result = "Room #: " + roomNumber + ", " +
                             "Room Type: " + roomType + ", " +
                             "Bed Type: " + bedType + ", " +
                     "Daily Rate: " + rate.ToString();
                }
            }
        }
    }
}
